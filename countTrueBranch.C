#include "rose.h"

using namespace SageBuilder;
using namespace SageInterface;
using namespace std;

class SimpleInstrumentation : public SgSimpleProcessing
{
    public:
        void visit (SgNode* astNode);
};

void
SimpleInstrumentation::visit(SgNode* astNode)
{
    int lineNumber;

    SgGlobal* globalScope = isSgGlobal(astNode);
    SgName var_name = "branchCount";

    SgTypeInt *intType = buildIntType();
    SgVariableDeclaration *variableDeclaration;
    SgVariableDeclaration *incrArrayDeclaration;
    SgVariableDeclaration *decrArrayDeclaration;

    if (globalScope != NULL) {
        // Create a parameter list with a parameter

        // Add argument of type "pointer to int"
        // SgPointerType *pointerType = buildPointerType(intType);
        SgInitializedName *var_init_name = buildInitializedName("", buildVoidType());

        // Create a function declaration for incrementing the argument
        SgFunctionParameterList *parameterList = buildFunctionParameterList();
        appendArg(parameterList, var_init_name);

        SgName incrFuncName = "increment";
        SgFunctionDeclaration *incrFunc = buildDefiningFunctionDeclaration(incrFuncName, buildVoidType(), parameterList, globalScope);
        SgBasicBlock *incrFuncBody = incrFunc->get_definition()->get_body();

        // Insert a statement in the function body
        SgVarRefExp *var_ref = buildVarRefExp(var_name, incrFuncBody);
        SgPlusPlusOp *pp_expression = buildPlusPlusOp(var_ref);
        SgExprStatement *ppStmt = buildExprStatement(pp_expression);

        // Insert a statement into the function body
        prependStatement(ppStmt, incrFuncBody);
        prependStatement(incrFunc, globalScope);
        variableDeclaration = buildVariableDeclaration ("branchCount", buildIntType());
        incrArrayDeclaration = buildVariableDeclaration("incrArr[10000]", buildIntType());
        decrArrayDeclaration = buildVariableDeclaration("decrArr[10000]", buildIntType());

        // Create a function declaration for decrementing the argument
        SgName decrFuncName = "decrement";
        SgFunctionDeclaration *decrFunc = buildDefiningFunctionDeclaration(decrFuncName, buildVoidType(), parameterList, globalScope);
        SgBasicBlock *decrFuncBody = decrFunc->get_definition()->get_body();

        // Insert a statement in the function body
        SgMinusMinusOp *mm_expression = buildMinusMinusOp(var_ref);
        SgExprStatement *mmStmt = buildExprStatement(mm_expression);

        // Insert a statement into the function body
        prependStatement(mmStmt, decrFuncBody);
        prependStatement(decrFunc, globalScope);

        // Add global variables
        prependStatement(decrArrayDeclaration, globalScope);
        prependStatement(incrArrayDeclaration, globalScope);
        prependStatement(variableDeclaration, globalScope);
    }

    SgIfStmt *ifBlock = isSgIfStmt(astNode);

    if (ifBlock != NULL) {
        lineNumber = ifBlock->get_file_info()->get_line();

        SgName incrementName("increment");
        SgName decrementName("decrement");

        // Insert a call to increment()
        SgExprStatement *incrCallStmt = buildFunctionCallStmt(incrementName, buildVoidType(), buildExprListExp(), ifBlock);
        // Check if "true body" exists
        if (ifBlock->get_true_body() != NULL)
            insertStatement(ifBlock->get_true_body(), incrCallStmt);

        // Insert a call to decrement()
        SgExprStatement *decrCallStmt = buildFunctionCallStmt(decrementName, buildVoidType(), buildExprListExp(), ifBlock);
        // Check if "false body" exists
        if (ifBlock->get_false_body() != NULL)
            insertStatement(ifBlock->get_false_body(), decrCallStmt);
    }
}

int
main(int argc, char *argv[])
{
    // Initialize and check compatibility.
    ROSE_INITIALIZE;

    SgProject* project = frontend(argc, argv);
    ROSE_ASSERT(project != NULL);

    SimpleInstrumentation treeTraversal;
    treeTraversal.traverseInputFiles (project, preorder);
    AstTests::runAllTests(project);

    return backend(project);
}

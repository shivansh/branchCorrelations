#include"rose.h"
class ClassicVisitor:public ROSE_VisitorPattern {
    public:
        //Overridevirturalfunctiondefinedinbaseclass
        void visit(SgGlobal *globalScope)
        {
            printf("Found the SgGlobal IR node\n");
        }

        void visit(SgFunctionDeclaration *functionDeclaration)
        {
            printf("Found a SgFunction Declaration IR node\n");
        }

        void visit(SgTypeInt *intType)
        {
            printf("Found a SgType Int IR node\n");
        }

        void visit(SgTypeDouble *doubleType)
        {
            printf("Found a SgTypeDouble IR node\n");
        }
        void visit(SgStatement *doubleType)
        {
            printf("Found a SgTypeDouble IR node\n");
        }

};

int main(int argc,char *argv[]){
    ROSE_INITIALIZE;
    SgProject *project=frontend(argc,argv);
    ROSE_ASSERT(project!=NULL);
    generateDOT( *project);
    return 0;
    // ClassicVisitor visitor_A;
    // traverseMemoryPoolVisitorPattern(visitor_A);
    // return backend(project);
}

#include "rose.h"

using namespace std;

int main( int argc, char * argv[] )
{
    ROSE_INITIALIZE;

    SgProject* project = frontend(argc,argv);
    ROSE_ASSERT(project != NULL);

    Rose_STL_Container<SgNode*> functionDeclarationList = NodeQuery::querySubTree (project,V_SgFunctionDeclaration);

    int counter = 0;
    for (Rose_STL_Container<SgNode*>::iterator i = functionDeclarationList.begin(); i != functionDeclarationList.end(); i++)
    {
        SgFunctionDeclaration* functionDeclaration = isSgFunctionDeclaration(*i);
        ROSE_ASSERT(functionDeclaration != NULL);

        if ( (*i)->get_file_info()->isCompilerGenerated() == false)
        {
            printf ("Function #%2d name is %s at line %d \n",
                    counter++,functionDeclaration->get_name().str(),
                    functionDeclaration->get_file_info()->get_line());
        }
    }
    return 0;
}

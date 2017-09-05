int branchCount;

void increment(void )
{
  ++branchCount;
}

int main(int argc,char **argv)
{
  int x = 1;
  int y;
  if (x == 1) {
    increment();
    y = 0;
  }
   else 
    y = 1;
  return 0;
}

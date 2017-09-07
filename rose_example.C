int branchCount;

void decrement(void )
{
  --branchCount;
}

void increment(void )
{
  ++branchCount;
}

int main(int argc,char **argv)
{
  int x = 0;
  if (x < 2) {
    increment();
{
      x = 0;
      x++;
    }
  }
   else {
    decrement();
{
      x = 5;
      x--;
    }
  }
  return 0;
}

********************************/

/*             container.h            */

/*******************************/

class container
{
protected:
 int numOfHeal;
 int numOfMagicWater;
public:
 container();
 void set ( int i , int j );
 int nOfHeal ();
 int nOfMW ();
 void display ();
 bool useHeal ();
 bool useMW ();
};
container :: container()
{
 set (0,0);
}
void container :: set ( int i , int j )
{
 numOfHeal = i;
 numOfMagicWater = j;
}
int container :: nOfHeal()
{
 return numOfHeal;
}
int container :: nOfMW()
{
 return numOfMagicWater;
}
void container :: display()
{
 cout<<"恢复剂（生命+100）还有"<<numOfHeal<<"个"<<endl;
 cout<<"魔法剂（魔法+ 80）还有"<<numOfMagicWater<<"个"<<endl;
}
bool container :: useHeal()
{
 numOfHeal--;
 return 1;
}
bool container :: useMW()
{
 numOfMagicWater--;
 return 1;
}

/********************************/

/*                player.h               */

/*******************************/

#include <iostream>
#include <iomanip.h>
#include <stdlib.h>
#include <time.h>
#include "container.h"

enum property { sw, ar, mg };
class Player
{
 friend void showinfo( Player &p1, Player &p2 );
 friend class Swordsman;
 friend class Archer;
 friend class Mage;
protected:
 int HP, HPmax, MP, MPmax, AP, DP, speed, EXP, LV,HPtemp,MPtemp;
 char name[10];
 property role;
 container bag;
public:
 virtual bool attack ( Player &p ) = 0;
 virtual bool specialatt (Player &p ) = 0;
 virtual void isLevelUp() =0;
 void ReFill();
 bool Death();
 void isDead();
 bool useHeal();
 bool useMW();
 void transfer( Player &p );
 char showRole();
protected:
 bool death;
};
void Player :: ReFill()
{
 HP = HPmax;
 MP = MPmax;
}
bool Player :: Death()
{
 return death;
}
void Player :: isDead()
{
 if ( HP <= 0 )
 {
  cout<<name<<"已阵亡。"<<endl;
  system("pause");
  death = 1;
 }
}
bool Player :: useHeal()
{
 if ( bag.nOfHeal()>0 )
 {
  HP = HP+100;
  if ( HP > HPmax )
   HP = HPmax;
  cout<<name<<"使用了恢复剂，生命值增加了100。"<<endl;
  bag.useHeal();
  system("pause");
  return 1;
 }
 cout<<"对不起，您没有恢复剂可以使用了。"<<endl;
 system("pause");
 return 0;
}
bool Player :: useMW()
{
 if ( bag.nOfMW() > 0 )
 {
  MP = MP+80;
  if ( MP > MPmax )
   MP = MPmax;
  cout<<"使用了魔法剂，魔法值增加了80。"<<endl;
  bag.useMW();
  system("pause");
  return 1;
 }
 cout<<"对不起，您没有魔法剂可以使用了。"<<endl;
 system("pause");
 return 0;
}
void Player :: transfer(Player &p)
{
 cout<<name<<"获得了"<<p.bag.nOfHeal()<<"个恢复剂和"<<p.bag.nOfMW()<<"个魔法剂。"<<endl;
 system("pause");
 bag.set( bag.nOfHeal() + p.bag.nOfHeal(), bag.nOfMW() + p.bag.nOfMW() );
}
char Player :: showRole()
{
 switch ( role )
 {
 case sw:
  cout<<setw(6)<<"骑士";
  break;
 case ar:
  cout<<setw(6)<<"弓箭手";
  break;
 case mg:
  cout<<setw(6)<<"法师";
  break;
 default :
  break;
 }
 return ' ';
}
void showinfo ( Player &p1 ,Player &p2 )
{
 cout<<"  ###################################################"<<endl;
 cout<<"  # 玩家 "<<setw(11)<<p1.name<<" LV."<<setw(3)<<p1.LV
  <<"# 敌人 "<<setw(11)<<p2.name<<" LV."<<setw(3)<<p2.LV<<'#'<<endl;
 cout<<"  # HP "<<setw(3)<<( p1.HP <= 999 ? p1.HP:999 )<<'/'<<setw(3)
  <<( p1.HPmax <= 999 ? p1.HPmax:999 )<<"  MP "<<setw(3)
  <<( p1.MP <= 999 ? p1.MP:999 )<<'/'<<setw(3)<<( p1.MPmax <= 999 ? p1.MPmax:999 )
  <<" # HP "<<setw(3)<<( p2.HP <= 999 ? p2.HP:999 )<<'/'<<setw(3)
  <<( p2.HPmax <= 999 ? p2.HPmax:999 )<<"  MP "<<setw(3)
  <<( p2.MP <= 999 ? p2.MP:999 )<<'/'<<setw(3)<<( p2.MPmax <= 999 ? p2.MPmax:999 )
  <<" #"<<endl;
 cout<<"  # AP "<<setw(3)<<( p1.AP <= 999 ? p1.AP:999 )
  <<" DP "<<setw(3)<<( p1.DP <= 999 ? p1.DP:999 )
  <<" Speed "<<setw(3)<<( p1.speed <=999 ? p1.speed:999 )
  <<"# AP "<<setw(3)<<( p2.AP <= 999 ? p2.AP:999 )
  <<" DP "<<setw(3)<<( p2.DP <= 999 ? p2.DP:999 )
  <<" Speed "<<setw(3)<<( p2.speed <=999 ? p2.speed:999 )
  <<'#'<<endl;
 cout<<"  # EXP"<<setw(7)<<p1.EXP<<" 职业 ";
 cout<<p1.showRole();
 cout<<"# EXP"<<setw(7)<<p2.EXP<<" 职业 ";
 cout<<p2.showRole() 
  <<'#'<<endl;
 cout<<"  ###################################################"<<endl;
 p1.bag.display();
}

/********************************/

/*          swordsman.h           */

/*******************************/

#include "Player.h"
class Swordsman : public Player
{
public:
 Swordsman ( int i ,char * cptr );
 void isLevelUp();
 bool attack( Player &p );
 bool specialatt( Player &p );
 void AI ( Player &p );
};
Swordsman :: Swordsman(int i ,char *cptr)
{
 role = sw;
 for (int j=0; j<10; j++)
  name[j] = cptr[j];
 HP = 150+8*(i-1);
 HPmax = 150+8*(i-1);
 MP = 75+2*(i-1);
 MPmax = 75+2*(i-1);
 AP = 25+4*(i-1);
 DP = 25+4*(i-1);
 speed = 25+2*(i-1);
 LV = i;
 death = 0;
 EXP = LV*LV*75;
 bag.set(i*5,i*5);
}
void Swordsman :: isLevelUp()
{
 if ( EXP >= LV*LV*75 )
 {
  LV++;
  AP += 4;
  DP += 4;
  HPmax += 8;
  MPmax += 2;
  speed += 2;
  cout<<name<<"升级了！"<<endl;
  cout<<"生命值增加了8点"<<endl
   <<"魔法值增加了2点"<<endl
   <<"速度增加了2点"<<endl
   <<"攻击力增加了4点"<<endl
   <<"防御力增加了4点"<<endl;
  isLevelUp();
 }
}
bool Swordsman :: attack(Player &p)
{

 double HPtemp = 0, EXPtemp = 0;
 double hit = 1;
 srand( time( NULL ) );
 if ( (speed>p.speed) && (rand()%100<(speed-p.speed)))
 {
  HPtemp = (int) ( (1.0*AP/p.DP)*AP*5/(rand()%4+10));
  cout<<name<<"先发制人，飞剑出鞘，击中"<<p.name<<"的脑门，"<<p.name<<"生命值减少了"<<HPtemp<<endl;
  p.HP = (int)(p.HP-p.HPtemp);
  EXPtemp = (int)(HPtemp*1.2);
 }
 if ( (speed<=p.speed) && (rand()%50<1) )
 {
  cout<<name<<"拔出利剑，一阵乱砍，"<<p.name<<"顺势躲开了。"<<endl;
  system("pause");
  return 1;
 }
 if (rand()%100<=10)
 {
  hit = 1.5;
  cout<<name<<"力量剧增，发出会心一击。";
 }
 HPtemp = (int)(hit*(1.0*AP/p.DP)*AP*30/(rand()%8+32));
 cout<<"猛然挥剑，一道银光掠过眼前，"<<p.name<<"被一道剑气穿堂而过，生命值减少了"<<HPtemp<<endl;
 EXPtemp = (int)(EXPtemp +HPtemp*1.2);
 p.HP = (int)(p.HP-HPtemp);
 cout<<name<<"获得了"<<EXPtemp<<"点经验。"<<endl;
 EXPtemp = (int)(EXPtemp+EXP);
 system("pause");
 return 1;
}
bool Swordsman :: specialatt(Player &p)
{
 if ( MP<40 )
 {
  cout<<"您的魔法值不够！"<<endl;
  system("pause");
  return 0;
 }
 else
 {
  MP = MP-40;
  if ( rand()%100<=10 )
  {
   cout<<name<<"刚刚使出重剑斩，"<<p.name<<"就来了个鹞子翻身，跳开了。"<<endl;
   system("pause");
   return 1;
  }
  double HPtemp = 0, EXPtemp = 0;
  double hit = 1;
  srand( time(NULL) );
  HPtemp = (int)(AP*1.2+20);
  EXPtemp = (int)(HPtemp*1.5);
  cout<<"使出浑身解数，大叫一声“重~~剑~~斩！”，拿出宝剑就向"<<p.name<<"砍去……"<<endl;
  cout<<p.name<<"生命值减少了"<<HPtemp<<"，"<<name<<"获得了"<<EXPtemp<<"点经验值。"<<endl;
  p.HP = (int)(p.HP-HPtemp);
  EXP = (int)(EXP+EXPtemp);
  system("pause");
 }
 return 1;
}
void Swordsman :: AI(Player &p)
{
 if ( (HP<=(int)((1.0*AP/DP)*p.AP*1.5)) && (HP+100<=1.1*HPmax) && (bag.nOfHeal()>0) && (p.HP>(int)((1.0*p.AP/DP)*p.AP*0.6)) ) 
 {
  useHeal();
 }
 else
 {
  if ( MP>=40 && HP>0.5*HPmax && rand()%10>7 )
  {
   specialatt(p);
   p.isDead();
  }
  else
  {
   if ( MP<40 && HP>0.5*HPmax && !bag.nOfMW() )
   {
    useMW();
   }
   else
   {
    attack(p);
    p.isDead();
   }
  }
 }
}

/********************************/

/*               archer.h               */

/*******************************/


class Archer : public Player
{
public:
 Archer (int i, char *cptr);
 void isLevelUp();
 bool attack(Player &p);
 bool specialatt(Player &p);
};
Archer :: Archer(int i, char *cptr)
{
 role = ar;
 for (int j=0; j<10; j++)
  name[j] = cptr[j];
 HP = 180+6*(i-1);
 HPmax = 180+6*(i-1);
 MP = 75+8*(i-1);
 MPmax = 75+8*(i-1);
 AP = 30+3*(i-1);
 DP = 24+3*(i-1);
 speed = 30+10*(i-1);
 LV = i;
 death = 0;
 EXP = (LV-1)*(LV-1)*70;
 bag.set(i*8,i*8);
}
void Archer :: isLevelUp()
{
 if ( EXP >= LV*LV*70 )
 {
  LV++;
  AP += 3;
  DP += 3;
  HPmax += 6;
  MPmax += 8;
  speed += 10;
  cout<<name<<"升级了！"<<endl;
  cout<<"生命值增加了6点"<<endl
   <<"魔法值增加了8点"<<endl
   <<"速度增加了10点"<<endl
   <<"攻击力增加了3点"<<endl
   <<"防御力增加了3点"<<endl;
  isLevelUp();
 }
}
bool Archer :: attack(Player &p)
{
 double HPtemp = 0, EXPtemp = 0;
 double hit = 1;
 srand( time( NULL ) );
 if ( (speed>p.speed) && (rand()%100<(speed-p.speed)))
 {
  HPtemp = (int) ( (1.0*AP/p.DP)*AP*2/(rand()%4+10));
  cout<<name<<"先放一箭，不偏不倚正好打中"<<p.name<<"的胸口"<<p.name<<"生命值减少了"<<HPtemp<<endl;
  p.HP = (int)(p.HP-p.HPtemp);
  EXPtemp = (int)(HPtemp*1.2);
 }
 if (rand()%100<1)
 {
  cout<<name<<"射出一支歪歪扭扭的箭，"<<name<<"很轻松的躲开了。"<<endl;
  system("pause");
  return 1;
 }
 if (rand()%100<=10)
 {
  hit = 1.5;
  cout<<name<<"拉足了弓，发出会心一击。";
 }
 HPtemp = (int)(hit*(1.0*AP/p.DP)*AP*30/(rand()%8+32));
 cout<<name<<"射出一支长箭，“嗖”的一声，插入了"<<p.name<<"的"<<(rand()%2==1 ? "胸膛":"大腿")<<p.name<<"生命值减少了"<<HPtemp<<endl;
 EXPtemp = (int)(EXPtemp +HPtemp*1.2);
 p.HP = (int)(p.HP-HPtemp);
 cout<<name<<"获得了"<<EXPtemp<<"点经验。"<<endl;
 EXPtemp = (int)(EXPtemp+EXP);
 system("pause");
 return 1;
}
bool Archer :: specialatt(Player &p)
{
 if ( MP<40 )
 {
  cout<<"您的魔法值不够！"<<endl;
  system("pause");
  return 0;
 }
 else
 {
  MP = MP-40;
  double HPtemp = 0, EXPtemp = 0;
  srand( time(NULL) );
  HPtemp = (int)(AP*1.4+18);
  EXPtemp = (int)(HPtemp*1.5);
  cout<<name<<"拿出3把长箭，大叫一声“流~~星~~箭~~！”3把长箭径直向"<<p.name<<"飞去，"<<p.name<<"无处闪躲……"<<endl;
  cout<<p.name<<"生命值减少了"<<HPtemp<<"，"<<name<<"获得了"<<EXPtemp<<"点经验值。"<<endl;
  p.HP = (int)(p.HP-HPtemp);
  EXP = (int)(EXP+EXPtemp);
  system("pause");
 }
 return 1;
}

/********************************/

/*              mage.h                 */

/*******************************/


class Mage : public Player
{
public:
 Mage ( int i ,char * cptr );
 void isLevelUp();
 bool attack( Player &p );
 bool specialatt( Player &p );
 bool AI ( Player &p );
};
Mage :: Mage(int i ,char *cptr)
{
 role = mg;
 for (int j=0; j<10; j++)
  name[j] = cptr[j];
 HP = 120+4*(i-1);
 HPmax = 120+4*(i-1);
 MP = 200+20*(i-1);
 MPmax = 200+20*(i-1);
 AP = 50+2*(i-1);
 DP = 20+2*(i-1);
 speed = 25+3*(i-1);
 LV = i;
 death = 0;
 EXP = (LV-1)*(LV-1)*65;
 bag.set(i*5,i*30);
}
void Mage :: isLevelUp()
{
 if ( EXP >= LV*LV*65 )
 {
  LV++;
  AP += 2;
  DP += 2;
  HPmax += 4;
  MPmax += 20;
  speed += 3;
  cout<<name<<"升级了！"<<endl;
  cout<<"生命值增加了4点"<<endl
   <<"魔法值增加了20点"<<endl
   <<"速度增加了3点"<<endl
   <<"攻击力增加了2点"<<endl
   <<"防御力增加了2点"<<endl;
  isLevelUp();
 }
}
bool Mage :: attack(Player &p)
{

 double HPtemp = 0, EXPtemp = 0;
 double hit = 1;
 srand( time( NULL ) );
 if ( (speed>p.speed) && (rand()%100<(speed-p.speed)))
 {
  HPtemp = (int) ( (1.0*AP/p.DP)*AP*3/(rand()%4+10));
  cout<<name<<"先是一记飞腿，踢向"<<p.name<<"的小腹，"<<p.name<<"生命值减少了"<<HPtemp<<endl;
  p.HP = (int)(p.HP-p.HPtemp);
  EXPtemp = (int)(HPtemp*1.2);
 }
 if (rand()%100<1)
 {
  cout<<name<<"默念咒语，"<<name<<"很轻松的躲开了。"<<endl;
  system("pause");
  return 1;
 }
 if (rand()%100<=10)
 {
  hit = 1.5;
  cout<<name<<"用足法力，发出会心一击。";
 }
 HPtemp = (int)(hit*(1.0*AP/p.DP)*AP*25/(rand()%8+35));
 cout<<name<<"抡起法杖，砸向"<<p.name<<"的"<<(rand()%2==1 ? "脑袋":"肩膀")<<p.name<<"生命值减少了"<<HPtemp<<endl;
 EXPtemp = (int)(EXPtemp +HPtemp*1.2);
 p.HP = (int)(p.HP-HPtemp);
 cout<<name<<"获得了"<<EXPtemp<<"点经验。"<<endl;
 EXPtemp = (int)(EXPtemp+EXP);
 system("pause");
 return 1;
}
bool Mage :: specialatt(Player &p)
{
 if ( MP<20 )
 {
  cout<<"您的魔法值不够！"<<endl;
  system("pause");
  return 0;
 }
 else
 {
  MP = MP-20;
  if ( rand()%100<=20 )
  {
   cout<<name<<"默念“！@#￥%……&*！@#￥￥%”，射出一道绿光，"<<p.name<<"跳得远远的。"<<endl;
   system("pause");
   return 1;
  }
  double HPtemp = 0, EXPtemp = 0;
  srand( time(NULL) );
  HPtemp = (int)(AP*1.1);
  EXPtemp = (int)(HPtemp*1.3);
  cout<<name<<"默念“！@#￥%……&*！@#￥￥%”，一道绿光射向"<<p.name<<"，"<<name<<"吸取了"<<p.name<<"的"<<HPtemp<<"点生命值。"<<endl;
  cout<<name<<"获得了"<<EXPtemp<<"点经验值。"<<endl;
  p.HP = (int)(p.HP-HPtemp);
  EXP = (int)(EXP+EXPtemp);
  if ( HP +HPtemp <= HPmax)
   HP = (int)(HP+HPtemp);
  else
   HP = HPmax;
  system("pause");
 }
 return 1;
}

/********************************/

/*             main.cpp               */

/*******************************/

#include <iostream>
#include "swordsman.h"
#include "archer.h"
#include "mage.h"
int main()
{
 system("mode con cols=55 lines=25 &color 9f"); 
 char temp[10];
 bool success = 0;
 cout<<"请输入玩家的名字：";
 cin>>temp;
 Player *human;
 int instemp;
 do 
 {
  cout<<"请选择角色：1.剑士；2.弓箭手；3.法师"<<endl;
  cin>>instemp;
  system("cls");
  switch (instemp)
  {
  case 1:
   human = new Swordsman(1,temp);
   success = 1;
   break;
  case 2:
   human = new Archer(1,temp);
   success = 1;
   break;
  case 3:
   human = new Mage(1,temp);
   success = 1;
   break;
  default:
   break;
  }  
 } while ( success!=1 );
 int j = 0;
 for (int i=0; j<5; i+=2)
 {
  j++;
  system("cls");
  cout<<"STAGE "<<j<<endl;
  cout<<"敌人介绍：一个"<<i<<"级的剑士。"<<endl;
  system("pause");
  Swordsman enemy(i,"敌方士兵");
  human->ReFill();
  while ( !human->Death() && !enemy.Death() )
  {
   success = 0;
   while ( success != 1 )
   {
    system("cls");
    showinfo(*human,enemy);
    cout<<"请下达命令："<<endl;
    cout<<"1.攻击 2.特殊攻击 3.使用恢复剂 4.使用魔法剂 0.退出游戏 "<<endl;
    cin>>instemp;
    switch (instemp)
    {
    case 0:
     cout<<"是否退出游戏？ Y/N "<<endl;
     char temp;
     cin>>temp;
     if ( temp=='Y' || temp=='y')
     {
      return 0;
     }
     else
      break;
    case 1:
     success = human->attack(enemy);
     human->isLevelUp();
     enemy.isDead();
     break;
    case 2:
     success = human->specialatt(enemy);
     human->isLevelUp();
     human->isDead();
    case 3:
     success = human->useHeal();
     break;
    case 4:
     success = human->useMW();
     break;
    default:
     break;
    }
   }
   if ( !enemy.Death() )
    enemy.AI(*human);
   else
    human->transfer(enemy);
   if ( human->Death() )
   {
    system("cls");
    cout<<endl<<endl<<endl<<endl<<endl<<setw(50)<<"胜败乃兵家常事，好男儿请重新再来。"<<endl;
    delete human;
    system("pause");
    return 0;
   }
  }
 }
 system("cls");
 cout<<endl<<endl<<endl<<endl<<endl<<setw(50)<<"所有敌人都已经被你消灭！，世界有恢复了往日的和平。"<<endl<<endl<<endl<<"终"<<endl<<endl<<endl<<endl<<endl;
 delete human;
 return 0;
}  
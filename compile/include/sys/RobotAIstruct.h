//--------------------------------------
//这里面的代码看看就行，别乱动啊~~~
//--------------------------------------


#pragma once

#define Info_MaxArsenals 2
#define Info_MaxObstacles 5
#define Info_MaxRobots 2
#define Info_MaxBullets 200




enum weapontypename
{
	WT_Cannon
	,WT_Shotgun
	,WT_RPG
	,WT_Machinegun
	,WT_Prism
	,WT_Tesla
	,WT_PlasmaTorch
	,WT_MissileLauncher
	,WT_ElectricSaw

	//二期
	,WT_GrenadeThrower
	,WT_MineLayer
};

enum enginetypename
{
	ET_Spider
	,ET_Robotman
	,ET_AFV
	,ET_UFO

	//二期
};

enum bullettypename
{
	BT_Cannonball
	,BT_ShotgunBall
	,BT_RPGBall
	,BT_MachinegunBall
	,BT_Prism_Laser
	,BT_Tesla_Lightning
	,BT_PlasmaBall
	,BT_TrackingMissile
	,BT_ElectricSaw


	//二期
	,BT_Grenade
	,BT_Mine

	,BT_TinyBall		//布雷器的辅助子弹


	//以下是功能性的类型

	,BT_NULL
};


struct RobotAI_Order
{
	//用于RobotAI中Update(..)方法的对机器人下达的操作命令
	int fire;	//控制武器开火与否
	int wturn;	//控制武器旋转与否
	int run;	//引擎操纵码之一，影响速度，具体功能因所选引擎而异
	int eturn;	//引擎操纵码之一，影响旋转，具体功能因所选引擎而异

	RobotAI_Order(){fire=0;wturn=0;run=0;eturn=0;}
};


//一个机甲的信息的结构体
struct RobotAI_RobotInformation
{
	int entityID;	//这个不用管啦

	int id;		//Battlefield.pRobot的下标 （myID就是这个）

	weapontypename weaponTypeName;	//武器种类（枚举类型）
	enginetypename engineTypeName;	//引擎种类（枚举类型）

	//机甲当前的信息
	Circle circle;		//引擎的圆形(结构体:x,y,radium)
	double engineRotation;	//引擎当前角度，与x轴正方向夹角
	double weaponRotation;	//武器当前角度，与x轴正方向夹角
	double vx,vy,vr;	//x轴投影速度，y轴投影速度，旋转角速度

	int hp;				//机甲当前剩余生命值


	int remainingAmmo;		//机甲当前剩余弹药量
	int cooling;			//机甲武器当前剩余冷却时间

};


//一个子弹的信息的结构体
struct RobotAI_BulletInformation
{
	int entityID;	//这个不用管啦

	int launcherID;	//子弹发射者的下标

	bullettypename type;		//子弹种类（枚举类型）

	Circle circle;		//子弹的圆形(结构体：x,y,radium)
	double rotation;	//引擎角度
	double vx,vy,vr;	//x轴投影速度，y轴投影速度，旋转角速度
};

//一个军火库的信息的结构体
struct RobotAI_ArsenalInformation
{
	Circle circle;	//军火库的圆形(结构体：x,y,radium)
	int respawning_time;	//当前剩余重新激活时间
};


//每帧的战场总信息结构体
struct RobotAI_BattlefieldInformation
{
	//使用最基本的数组存储

	int num_robot;	//机甲数量（包括已经挂了的）

	RobotAI_RobotInformation robotInformation[Info_MaxRobots];


	int num_bullet;	//当前子弹数量（便于循环访问于何时终止）

	RobotAI_BulletInformation bulletInformation[Info_MaxBullets];


	int num_obstacle;	//地图上的障碍物数量（便于循环访问于何时终止）

	Circle obstacle[Info_MaxObstacles];


	int num_arsenal;	//地图上的军火库数量（便于循环访问于何时终止）

	RobotAI_ArsenalInformation arsenal[Info_MaxArsenals];



	Box boundary;		//战场边界，Box结构体
};

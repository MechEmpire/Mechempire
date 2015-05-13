//一些游戏中可能用到的结构体
//AI开发者可以选择性使用

#pragma once
using namespace std;
#include <cmath>
#include <cstdlib>
#include <ctime>
#define PI 3.1415926535898

//形状种类（枚举类型）
enum shapes{S_Circle,S_Box,S_Beam};



//点
struct Point
{
	double x;
	double y;
};

//圆形
struct Circle
{
	double x;	//圆心坐标x
	double y;	//圆心坐标y
	double r;	//圆形半径
};

//矩形
struct Box
{
	double x;	//矩形中心坐标x
	double y;	//矩形中心坐标y
	double width;	//矩形宽（水平）
	double height;	//矩形高（垂直）
};

//线段
struct Segment
{
	double x1,y1;
	double x2,y2;
};

//射线
struct Beam
{
	//起点(x,y)
	double x;
	double y;
	double rotation;	//角度

	//终点(x,y)
	double ex,ey;
};



//这里是一些可能会用到的函数
//你完全可以忽略它们，而使用自己编写的函数
//这部分的函数体实现在GlobalFunction.cpp中
extern Point myRotate(double,double,double,double,bool);
extern double AngleAdjust(double &);
extern double AnglePlus(double,double);
extern double AngleToRadian(double);
extern double RadianToAngle(double);
extern bool HitTestCirclePoint(const Circle &,const double &,const double y);
extern bool HitTestCircles(const Circle &, const Circle &);
extern bool HitTestBeamCircle(const Beam &,const Circle &);
extern Point GetHitPoint(Beam,Circle);
extern void SetSeed();
extern double Random0_1();
extern int Random(int,int);
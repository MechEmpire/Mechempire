#include "struct.h"


//这里是一些可能会用到的函数
//你完全可以忽略它们，而使用自己编写的函数





//旋转函数
//说明：返回旋转后的点
//参数：x	...	x轴坐标
//		y	...	y轴坐标
//		s	...要旋转角度的sin值
//		c	...要旋转角度的cos值
//		re	...true=顺时针，false=逆时针
Point myRotate(double x,double y,double s,double c,bool re)
{
	Point result;
	if(re)
	{
		result.x=x*c+y*s;
		result.y=y*c-x*s;
	}
	else
	{
		result.x=x*c-y*s;
		result.y=y*c+x*s;
	}
	return result;
}



//角度（度数）调整
//说明：返回范围在-180~180之间的角度数
//参数：c	...	角度数
double AngleAdjust(double &c)
{
	while(c>180)
	{
		c-=360;
	}
	while(c<=-180)
	{
		c+=360;
	}
	return c;
}


//角度（度数）相加
//说明：返回旋转后的点
double AnglePlus(double a,double b)
{
	//角度相加减
	double c=a+b;
	AngleAdjust(c);
	return c;
}

//角度数转弧度数函数
double AngleToRadian(double angle)
{
	//角度转弧度
	return angle/180*PI;
}

//弧度数转角度数函数
double RadianToAngle(double radian)
{
	return radian/PI*180;
}

//碰撞检测：圆形与点
//参数：c	...	圆形（结构体）
//		x	...	x轴坐标
//		y	...	y轴坐标
bool HitTestCirclePoint(const Circle &c,const double &x,const double &y)
{
	double dx=c.x-x,	dy=c.y-y;

	if(abs(dx)>c.r || abs(dy)>c.r)
	{
		return false;
	}

	double dis2=dx*dx+dy*dy;
	return (c.r*c.r>dis2);
}

//碰撞检测：圆形与圆形
//参数：c1	...	圆形1（结构体）
//		c2	...	圆形2（结构体）
bool HitTestCircles(const Circle &c1, const Circle &c2)
{
	double xx=c1.x-c2.x,	yy=c1.y-c2.y;
	double rr=c1.r+c2.r;

	if(abs(xx)>rr || abs(yy)>rr)
	{
		return false;
	}

	double dis2=xx*xx+yy*yy;
	
	return (rr*rr>=dis2);
}

//碰撞检测：射线与圆形
//参数：b	...	射线（结构体）
//		c	...	圆形（结构体）
bool HitTestBeamCircle(const Beam &b,const Circle &c)
{
	
	double br=AngleToRadian(b.rotation);
	double k=tan(br);
	double g=k*c.x-c.y-k*b.x+b.y;	//直线一般式的值
	double d2=g*g/(k*k+1);			//圆心到直线距离平方
	if(c.r*c.r>=d2)
	{
		//直线与圆已经相交，下面判断方向
		double dy=c.y-b.y;
		double ss=sin(br);
		
		if((ss>0 && dy>0)||(ss<0 && dy<0))
		{
			return true;
		}
	}
	return false;
}




//获得射线与圆形碰撞点
//参数：b	...	射线（结构体）
//		c	...	圆形（结构体）
Point GetHitPoint(Beam b,Circle c)
{
	Point p;
	p.x=0;
	p.y=0;
	
	//暂未考虑rotation=90的情况
	double brr=AngleToRadian(b.rotation);
	double k=tan(brr);//直线斜率
	double g=k*c.x-c.y-k*b.x+b.y;	//直线一般式的值
	double d=abs(g)/sqrt(k*k+1);			//圆心到直线距离
	
	double rr=AnglePlus(b.rotation,90);		//垂线角度
	double rrr=AngleToRadian(rr);
	
	double gap=sqrt(c.r*c.r-d*d);	//射线上滑动距离

	double sign;
	if(g>0)
	{
		//y系数为负，g>0圆心在直线下方，往上移
		sign=1;
	}
	else
	{
		sign=-1;
	}


	//垂足坐标
	double xc=c.x+sign*d*cos(rrr);
	double yc=c.y+sign*d*sin(rrr);



	if(b.x<xc)
	{
		if(cos(brr)>0)
		{
			p.x=xc-gap*cos(brr);
			p.y=yc-gap*sin(brr);
		}
		else
		{
			p.x=xc+gap*cos(brr);
			p.y=yc+gap*sin(brr);
		}
	}
	else
	{
		if(cos(brr)>0)
		{
			p.x=xc+gap*cos(brr);
			p.y=yc+gap*sin(brr);
		}
		else
		{
			p.x=xc-gap*cos(brr);
			p.y=yc-gap*sin(brr);
		}
	}

	//1.首先找c的圆心作b的垂线与b的交点
	//2.勾股定理算出另一直角边长度


	return p;
}



//随机数播种（用时间）
void SetSeed()
{
	srand( (unsigned)time( 0 )+7); 
}


//产生0-1的随机数的函数
double Random0_1(){
	//产生0-1的随机数的函数
	int temp;
	double r;
	temp=rand()%1000;
	r=(double)temp/1000;
	return r;
}



//产生[minv,maxv]之间整数的随机函数
int Random(int minv,int maxv)
{
	int gap=maxv-minv;
	if(maxv<=minv)
	{
		return 0;
	}
	return (minv+rand()%(gap+1));
	
}
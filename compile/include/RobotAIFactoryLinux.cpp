// RobotAIFactory.cpp : 定义 DLL 应用程序的导出函数。
//

#include "sys/RobotAI_Interface.h"
#include "RobotAI.h"


extern "C" RobotAI_Interface* Export()
{
	return (RobotAI_Interface*)new RobotAI();
}

extern "C" void FreeRobotAIPointer(RobotAI_Interface* p)
{
	delete p;
}

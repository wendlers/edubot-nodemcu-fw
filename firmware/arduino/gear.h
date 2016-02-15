#ifndef __GEAR_H__
#define __GEAR_H__

class Gear 
{
public:

	Gear(int pwmA, int dirA, int pwmB, int dirB);

	void setSpeed(int motor, int speed);

	int getSpeed(int motor);

	void setDir(int motor, int dir);	

	int getDir(int motor);	

private:

	struct motor {
		int pinPwm;
		int pinDir;
		int speed;
		int dir;	
	};

	motor motors[2];
};

#endif

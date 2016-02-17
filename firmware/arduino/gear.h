#pragma once 

class Gear 
{
public:

	Gear(int pwmA, int dirA, int pwmB, int dirB);

	void setSpeed(int motor, int speed);

	int getSpeed(int motor);

	void setDir(int motor, int dir);	

	int getDir(int motor);	

private:

	struct Motor {
		int pinPwm;
		int pinDir;
		int speed;
		int dir;	
	};

	Motor motors[2];
};


#include <Arduino.h>
#include "gear.h"

Gear::Gear(int pwmA, int dirA, int pwmB, int dirB)
{
	motors[0].pinPwm = pwmA;
	motors[0].pinDir = dirA;
	motors[1].pinPwm = pwmB;
	motors[1].pinDir = dirB;

	for(int i = 0; i < 2; i++) {
		pinMode(motors[i].pinPwm, OUTPUT);
		pinMode(motors[i].pinDir, OUTPUT);
		
		setSpeed(i, 0);
		setDir(i, 0);
	}
}

void Gear::setSpeed(int motor, int speed)
{
	int idx = motor & 1;

	motors[idx].speed = speed & 0x3ff;
	analogWrite(motors[idx].pinPwm, motors[idx].speed);
}

int Gear::getSpeed(int motor)
{
	int idx = motor & 1;

	return motors[idx].speed;
}

void Gear::setDir(int motor, int dir)	
{
	int idx = motor & 1;

	motors[idx].dir = dir & 1;
	digitalWrite(motors[idx].pinDir, motors[idx].dir);
}

int Gear::getDir(int motor)
{
	int idx = motor & 1;

	return motors[idx].dir;
}

#pragma once

class Range
{
public:

	Range(int trig, int echo, unsigned int update = 200);

	int getDistance();

	void update();

private:

	struct Sensor {
		int pinTrig;
		int pinEcho;
		unsigned long echoTime[2];
	};

	Sensor sensor;

	unsigned long nextUpdate = 0;
	unsigned int updateRate = 250;
};

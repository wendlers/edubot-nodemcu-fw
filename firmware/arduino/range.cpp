#include <Arduino.h>
#include "range.h"

Range::Range(int trig, int echo, unsigned int update)
{
	sensor.pinTrig = trig;
	sensor.pinEcho = echo;

	sensor.echoTime[0] = 0;
	sensor.echoTime[1] = 0;

	updateRate = update;

	pinMode(sensor.pinTrig, OUTPUT);
	pinMode(sensor.pinEcho, INPUT);

	digitalWrite(sensor.pinTrig, LOW);
}

int Range::getDistance()
{
	return sensor.echoTime[1] / 58;
}

void Range::update()
{
	if(nextUpdate < micros()) {
		
		digitalWrite(sensor.pinTrig, LOW);
		delayMicroseconds(2);
		digitalWrite(sensor.pinTrig, HIGH);
		delayMicroseconds(10);
		digitalWrite(sensor.pinTrig, LOW);

		unsigned long duration = pulseIn(sensor.pinEcho, HIGH, 400 * 58);

		if(sensor.echoTime[0] >= duration - 100 && sensor.echoTime[0] <= duration + 100) {
			sensor.echoTime[1] = (sensor.echoTime[0] + duration) / 2; 
		}

		sensor.echoTime[0] = duration;
 
		nextUpdate = micros() + 1000 * updateRate;
	}
}

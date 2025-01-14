#version 450

// in는 atrribute라는 뜻이다.
in vec3 a_Position;
in vec3 a_Velocity;
in float a_EmitTime;
in float a_LifeTime;
in float a_AmpTime;
in float a_PeriodTime;

uniform float u_Time;
uniform vec3 u_Accel;

bool bLoop = true; // 숙제.. (true, false에 따라서 반복적으로 생성시킬 것인가?)

const float g_PI = 3.14;
const mat3 g_RotMat = mat3(0, -1, 0, 1, 0, 0, 0, 0, 0); // ★GLSL은 열 기준이다. 즉 (cos90, -sin90, 0, sin90, cos90, 0, 0, 0, 0)의 순서로 행렬의 값을 넣어주면 된다.

void main()
{
	float time = u_Time - a_EmitTime;
	float timeSquare = time * time;

	vec3 newPos;
	if(time > 0)
	{
		float temp = time / a_LifeTime;
		float fractional = fract(temp); // 쉐이더 자체 제공 - 소수점 아랫 부분만 뺀다.
		time = fractional * a_LifeTime;
		timeSquare = time * time;

		float amp = a_AmpTime;			// 높이
		float period = a_PeriodTime;	// 폭
		newPos = a_Position + (a_Velocity * time) + (0.5f * u_Accel * timeSquare);
		newPos = newPos + amp * sin(period * time * 2.0 * g_PI);
		newPos.z = 0;
	}
	else
	{
		newPos = vec3(-1000000, -1000000, -1000000);
	}
	
	gl_Position = vec4(newPos, 1);
}
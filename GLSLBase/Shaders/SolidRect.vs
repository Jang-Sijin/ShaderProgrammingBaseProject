#version 450

// in는 atrribute라는 뜻이다.
in vec3 a_Position;

void main()
{
	gl_Position = vec4(a_Position, 1);
}

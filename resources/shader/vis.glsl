
extern iChannel0

vec3 view(vec2 p)
{
	number r = love_ScreenSize.x/love_ScreenSize.y;
	number x = p.x-fract(p.x*80.)/80.;
	number h = texel(iChannel0,vec2(x,0)).x;
	
	if (p.y <= h-fract(h*80.*r)/(80.*r)) {
		number py = p.y - fract(p.y*80.*r)/(80.*r);
		return vec3(h,h,py)*1.5;
	}
	return vec3(0.,0.,0.0);
	
}

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){

	vec2 p = screen_coords.xy / love_ScreenSize.xy;
	vec4 temp = vec4(view(p), 1.);
  return temp
}
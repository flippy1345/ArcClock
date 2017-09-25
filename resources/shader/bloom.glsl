extern vec3 iResolution;
extern number iTime;

#define saturate(x) (clamp(x, 0., 1.))


const number PI = 3.14159;

number blob(vec2 pos, vec2 center, number power)
{
    vec2 d = saturate(pow(pos - center, vec2(power)));

    return 1. / abs(d.x + d.y);
}

vec2 rotate(vec2 p, number t)
{
    return mat2(cos(t), -sin(t),
                  sin(t),  cos(t)) * p;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	//Get coordinates in the range [-1.0, 1.0]
    vec2 uv = (fragCoord.xy) / iResolution.xy;
    uv = (uv - 0.5) * 2.0;

    //Adjust for aspect ratio
    vec2 aspect_uv = uv * (iResolution.xy / iResolution.y);


    number blobs = 0.8 * blob(aspect_uv, vec2(0.), 2.);

    number phi = 0.;

    const int N = 7;

    for (int i = 0; i < N; ++i)
    {
        blobs += 0.0001 * blob(rotate(aspect_uv, phi),
                               vec2(sin(iTime + phi) * 0.64, 0.),
                               4.);

        blobs += 0.001 * blob(rotate(aspect_uv, phi),
                              vec2(-sin(iTime + phi + 5. * PI / 6.) * 0.50, 0.),
                              2.);
        phi += PI / number(N);
    }

    number x = smoothstep(3., 6., blobs);
    number y = smoothstep(3., 5., blobs);
    number z = smoothstep(3., 8., blobs);

    fragColor = vec4(2.1, 2., 2.1, 2.) - vec4(x * vec3(1., 0.5, 0.5) +
                                              y * vec3(0.5, 1., 0.5) +
                                              z * vec3(0.5, 0.5, 1.), 1.);


    fragColor = vec4((1. - vec3(pow(length(uv * 0.4), 1.5))) * vec3(0.9, 1.0, 0.9),
                     1.) * saturate(pow(fragColor, vec4(2.7)));
}


vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords){
    vec2 fragCoord = texture_coords * iResolution.xy;
    mainImage( color, fragCoord );
    return color;
}

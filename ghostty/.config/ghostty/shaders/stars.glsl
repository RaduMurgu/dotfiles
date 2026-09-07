// ─────────────── tweakables ───────────────
// transparent background
const bool transparent = true;
// terminal contents luminance threshold to be considered background (0.0 to 1.0)
const float threshold = 0.15;
// seconds for one layer to travel from far to near — HIGHER = SLOWER
const float cycleTime = 60.;
// divisions of grid — lower = fewer but larger/brighter stars
const float repeats = 30.;
// number of layers (depth steps). Keep fairly high to avoid visible popping.
const float layers = 21.;
// fraction of grid cells that actually contain a star (0.0 to 1.0) — LOWER = SPARSER
const float density = 0.2;
// star tightness — higher = smaller, dimmer points
const float starSize = 280.;
// ──────────────────────────────────────────

// star colours
const vec3 blue = vec3(51., 64., 195.) / 255.;
const vec3 cyan = vec3(117., 250., 254.) / 255.;
const vec3 white = vec3(255., 255., 255.) / 255.;
const vec3 yellow = vec3(251., 245., 44.) / 255.;
const vec3 red = vec3(247, 2., 20.) / 255.;

float luminance(vec3 color) {
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

// spectrum function
vec3 spectrum(vec2 pos) {
    pos.x *= 4.;
    vec3 outCol = vec3(0);
    if (pos.x > 0.) {
        outCol = mix(blue, cyan, fract(pos.x));
    }
    if (pos.x > 1.) {
        outCol = mix(cyan, white, fract(pos.x));
    }
    if (pos.x > 2.) {
        outCol = mix(white, yellow, fract(pos.x));
    }
    if (pos.x > 3.) {
        outCol = mix(yellow, red, fract(pos.x));
    }
    return 1. - (pos.y * (1. - outCol));
}

float N21(vec2 p) {
    p = fract(p * vec2(233.34, 851.73));
    p += dot(p, p + 23.45);
    return fract(p.x * p.y);
}

vec2 N22(vec2 p) {
    float n = N21(p);
    return vec2(n, N21(p + n));
}

mat2 scale(vec2 _scale) {
    return mat2(_scale.x, 0.0,
        0.0, _scale.y);
}

vec3 stars(vec2 uv, float offset) {
    // Speed is now independent of the layer count.
    // offset / layers keeps the layers evenly spread through the cycle.
    float timeScale = -iTime / cycleTime - offset / layers;
    float trans = fract(timeScale);
    float newRnd = floor(timeScale);

    vec3 col = vec3(0.);

    // Translate uv then scale for center
    uv -= vec2(0.5);
    uv = scale(vec2(trans)) * uv;
    uv += vec2(0.5);

    // Create square aspect ratio
    uv.x *= iResolution.x / iResolution.y;

    // Create boxes
    uv *= repeats;

    // Get position
    vec2 ipos = floor(uv);

    // Thin out the field: leave most cells empty
    if (N21(ipos + vec2(newRnd * 37.7, offset * 91.3 + 5.1)) > density) {
        return col;
    }

    // Return uv as 0 to 1
    uv = fract(uv);

    // Calculate random xy and size
    vec2 rndXY = N22(newRnd + ipos * (offset + 1.)) * 0.9 + 0.05;
    float rndSize = N21(ipos) * 100. + starSize;

    vec2 j = (rndXY - uv) * rndSize;
    float sparkle = 1. / dot(j, j);

    col += spectrum(fract(rndXY * newRnd * ipos)) * vec3(sparkle);
    col *= smoothstep(1., 0.8, trans);

    return col;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;

    vec3 col = vec3(0.);
    for (float i = 0.; i < layers; i++) {
        col += stars(uv, i);
    }

    // Sample the terminal screen texture including alpha channel
    vec4 terminalColor = texture(iChannel0, uv);

    if (transparent) {
        col += terminalColor.rgb;
    }

    // Make a mask that is 1.0 where the terminal content is not black
    float mask = 1. - step(threshold, luminance(terminalColor.rgb));
    vec3 blendedColor = mix(terminalColor.rgb, col, mask);

    // Apply terminal's alpha to control overall opacity
    fragColor = vec4(blendedColor, terminalColor.a);
}

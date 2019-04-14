// i did not write this file. original can be found at:
// https://github.com/udf/misc_scripts/blob/master/rainbow/rainbow.cpp
#include <iostream>
#include <cstdio>
#include <string>
#include <valarray>
#include <vector>
#include <cmath>

using std::valarray, std::vector;

template <class T>
valarray<T> lerp(valarray<T> x, valarray<T> y, T s)
{
    return x * (1 - s) + y * s;
}

template <class T>
valarray<T> reorder(const valarray<T> &in, const vector<size_t> order)
{
    valarray<T> out(order.size());
    for (size_t i = 0; i < order.size(); ++i)
        out[i] = in[order[i]];
    return out;
}

// ported from https://stackoverflow.com/a/19400360
valarray<double> hsv_to_rgb(valarray<double> &HSV)
{
    HSV[0] = std::fmod(100 + HSV[0], 1.0);

    double hue_slice = 6.0 * HSV[0];
    double hue_slice_integer = std::floor(hue_slice);
    double hue_slice_interpolant = hue_slice - hue_slice_integer;

    valarray<double> temp_RGB = {
        HSV[2] * (1.0 - HSV[1]),
        HSV[2] * (1.0 - HSV[1] * hue_slice_interpolant),
        HSV[2] * (1.0 - HSV[1] * (1.0 - hue_slice_interpolant))
    };

    double is_odd_slice = std::fmod(hue_slice_integer, 2.0);
    double three_slice_selector = 0.5 * (hue_slice_integer - is_odd_slice);

    valarray<double> scrolling_RGB_for_even_slices = {HSV[2], temp_RGB[2], temp_RGB[0]};
    valarray<double> scrolling_RGB_for_odd_slices = {temp_RGB[1], HSV[2], temp_RGB[0]};
    valarray<double> scrolling_RGB = lerp(scrolling_RGB_for_even_slices, scrolling_RGB_for_odd_slices, is_odd_slice);

    double is_not_first_slice = std::clamp(three_slice_selector, 0.0, 1.0);
    double is_not_second_slice = std::clamp(three_slice_selector - 1, 0.0, 1.0);

    return lerp(
        scrolling_RGB,
        lerp(
            reorder(scrolling_RGB, {2, 0, 1}),
            reorder(scrolling_RGB, {1, 2, 0}),
            is_not_second_slice
        ),
        is_not_first_slice
    );
}

void colour(int c)
{
    if (c >= 0)
        printf("\x1b[38;5;%dm", c);
    else
        printf("\x1b[39m");
}

void hsv_esc(valarray<double> in)
{
    valarray<double> c = hsv_to_rgb(in);
    
    int r = (c[0] * 5);
    int g = (c[1] * 5);
    int b = (c[2] * 5);
    
    colour(16 + 36*r + 6*g + b);
}

int main(int argc, char *argv[])
{
    if (argc <= 1) {
        return 1;
    }

    std::string text = "";
    for (int i = 1; i < argc; i++) {
        if (i != 1)
            text += " ";
        text += std::string(argv[i]);
    }

    for (size_t i = 0; i < text.length(); i++) {
        hsv_esc({i / (double)text.length(), 0.6, 1.0});
        printf("%c", text[i]);
        if (text[i] == '%')
            printf("%c", text[i]);
    }
    colour(-1);
    return 0;
}

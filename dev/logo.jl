using Pkg;
Pkg.activate("dev");

using Colors
using ConformalPrediction
using CounterfactualExplanations
using CounterfactualExplanations.Data
using CounterfactualExplanations.Models
using Distributions
using EasyFit
using Flux
using LaplaceRedux
using LinearAlgebra
using Luxor
using MLJBase
using StatsBase: sample
using Random

julia_colors = Dict(
    :blue => Luxor.julia_blue,
    :red => Luxor.julia_red,
    :green => Luxor.julia_green,
    :purple => Luxor.julia_purple,
)
bg_color = RGB(181/255, 198/255, 255/255)

function dog_head(radius; main_color=julia_colors[:blue], bg_color=bg_color)

    sethue(main_color)
    setline(Int(round(radius / 50)))

    @layer begin

        translate(Point(0, -0.4radius))

        @layer begin

            # Ears:
            C, D = [Point(x, 0.3radius) for x in [-0.8radius, 0.8radius]]
            @layer begin
                rotate(0.15 * π)
                ellipse(C, 0.5radius, 1.25radius, action=:fill)
            end
            @layer begin
                rotate(-0.15 * π)
                ellipse(D, 0.5radius, 1.25radius, action=:fill)
            end

            # Head shape:
            A, B = [Point(x, 0) for x in [-0.75radius, 0.75radius]]
            newpath()
            arc2sagitta(B, A, 1.5radius, action=:path)
            arc2sagitta(A, B, 0.75radius, action=:path)
            closepath()
            sethue(bg_color)
            do_action(:fill)

        end

        # Eyes
        E1, E2 = [Point(x, 0.3radius) for x in [-0.4radius, 0.4radius]]
        ellipse(E1, 0.3radius, 0.4radius, action=:fill)
        ellipse(E2, 0.3radius, 0.4radius, action=:fill)

        # Mouth
        @layer begin
            translate(Point(0, 0.9radius))
            y = 0.3radius
            pt1 = Point(0, y)
            line(Point(0, 0), pt1, action=:stroke)
            pt2 = Point(-0.2radius, y)
            pt3 = Point(0.2radius, y)
            arc2sagitta(pt1, pt2, 0.11radius, action=:stroke)
            arc2sagitta(pt3, pt1, 0.11radius, action=:stroke)

        end

        # Nose
        @layer begin
            translate(Point(0, 0.9radius))
            rotate(π)
            juliacircles(0.15radius, action=:path)
            points = simplify(pathtopoly()[1], 0.25)
            hull = polyhull(points)
            poly(hull, close=true, action=:fill)
            juliacircles(0.15radius)
        end


    end

end

function logo_picture(
    frame_size=500
)

    radius = frame_size / 3
    dog_head(radius)

end

function draw_small_logo(width=500; bg_color="transparent", filename="profile/www/logo.png", kwrgs...)
    frame_size = width
    Drawing(frame_size, frame_size, filename)
    if !isnothing(bg_color)
        background(bg_color)
    end
    origin()
    logo_picture(width)
    finish()
    preview()
end

function draw_wide_logo(
    filename="profile/www/wide_logo.png";
    _pkg_name="Taija",
    font_size=150,
    font_family="Tamil MN",
    font_fill=bg_color,
    font_color=Luxor.julia_blue,
    bg_color="transparent",
    picture_kwargs...
)

    # Setup:
    height = Int(round(font_size * 1.5))
    fontsize(font_size)
    fontface(font_family)
    strs = split(_pkg_name)
    text_col_width = Int(round(maximum(map(str -> textextents(str)[3], strs)) * 1.05))
    width = Int(round(height + text_col_width))
    cw = [text_col_width, height]
    cells = Luxor.Table(height, cw)
    ms = Int(round(height / 10))
    db_stroke_size = Int(round(height / 50))

    Drawing(width, height, filename)
    origin()
    background(bg_color)

    # Text:
    @layer begin
        Luxor.translate(cells[1])
        fontsize(font_size)
        fontface(font_family)
        tiles = Tiler(cells.colwidths[2], height, length(strs), 1)
        for (pos, n) in tiles
            @layer begin
                Luxor.translate(pos)
                setline(Int(round(db_stroke_size / 5)))
                setcolor(font_fill)
                textoutlines(strs[n], O, :path, valign=:middle, halign=:center)
                fillpreserve()
                setcolor(font_color..., 1.0)
                strokepath()
            end
        end
    end

    # Picture:
    @layer begin
        Luxor.translate(cells[2])
        logo_picture(height)
    end

    finish()
    preview()
end

function draw_long_logo(
    filename="profile/www/long_logo.png";
    _pkg_name="Taija",
    font_size=800,
    font_family="Tamil MN",
    font_fill=bg_color,
    font_color=Luxor.julia_blue,
    _bg_color=RGB(14/255, 23/255, 55/255),
    picture_kwargs...
)

    # Setup:
    height = Int(round(font_size * 7.5))
    width = 0.6 * height

    Drawing(width, height, filename)
    origin()
    background(_bg_color)

    # Picture:
    @layer begin
        translate(Point(0, -0.1*height))
        logo_picture(height * 0.85)
    end

    # Text:
    @layer begin
        translate(Point(0, 0.35*height))
        fontsize(font_size)
        fontface(font_family)
        setcolor(font_fill)
        textoutlines(_pkg_name, O, :path, valign=:middle, halign=:center)
        fillpreserve()
        setcolor(font_color..., 1.0)
    end

    @layer begin
        img = readpng("profile/www/qr_code.png")
        w = img.width
        h = img.height
    end

    finish()
    preview()
end

draw_small_logo()
draw_wide_logo()
draw_long_logo(bg_color=bg_color)

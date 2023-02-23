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
bg_color = RGBA(julia_colors[:blue]..., 0.2)

function dog_head(radius)

    @layer begin

        translate(Point(0, -0.4radius))

        A, B = [Point(x, 0) for x in [-0.75radius, 0.75radius]]

        # Head shape:
        @layer begin
            newpath()
            arc2sagitta(B, A, 1.5radius, action=:path)
            arc2sagitta(A, B, 0.75radius, action=:path)
            closepath()
            do_action(:stroke)
        end

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
            arc2sagitta(pt1, pt2, 0.11radius, action = :stroke)
            arc2sagitta(pt3, pt1, 0.11radius, action = :stroke)

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
    frame_size=500;
    ms=frame_size // 50
)

    radius = frame_size / 3
    dog_head(radius)

end

function draw_small_logo(width=500; bg_color="transparent", filename="www/logo.svg", kwrgs...)
    frame_size = width
    Drawing(frame_size, frame_size, filename)
    if !isnothing(bg_color)
        background(bg_color)
    end
    origin()
    logo_picture(width; kwrgs...)
    finish()
    preview()
end

function animate_small_logo(filename="www/logo.gif", width=500; bg_color="transparent", kwrgs...)
    frame_size = width
    anim = Movie(frame_size, frame_size, "logo", 1:10)
    function backdrop(scene, framenumber)
        background(bg_color)
    end
    function frame(scene, framenumber)
        logo_picture(; kwrgs..., m_alpha=1.0, switch_ce_color=false, bg_color=julia_colors[:blue], n_steps=framenumber)
    end
    animate(
        anim, 
        [
            Scene(anim, backdrop, 1:10),
            Scene(anim, frame, 1:10, easingfunction=easeinoutcubic)
        ],
        creategif=true,
        pathname=filename
    )
end

function draw_wide_logo(
    filename="www/wide_logo.png";
    _pkg_name="Julia TrustworthyML",
    font_size=150,
    font_family="Tamil MN",
    font_fill=bg_color,
    font_color=Luxor.julia_blue,
    bg_color="transparent",
    picture_kwargs...
)

    # Setup:
    height = Int(round(font_size * 2.4))
    fontsize(font_size)
    fontface(font_family)
    strs = split(_pkg_name)
    text_col_width = Int(round(maximum(map(str -> textextents(str)[3], strs)) * 1.05))
    width = Int(round(height + text_col_width))
    cw = [height, text_col_width]
    cells = Luxor.Table(height, cw)
    ms = Int(round(height / 10))
    db_stroke_size = Int(round(height / 50))

    Drawing(width, height, filename)
    origin()
    background(bg_color)

    # Picture:
    @layer begin
        Luxor.translate(cells[1])
        logo_picture(
            ;
            frame_size=height,
            margin=0.1,
            ms=ms,
            db_stroke_size=db_stroke_size,
            picture_kwargs...
        )
    end

    # Text:
    @layer begin
        Luxor.translate(cells[2])
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

    finish()
    preview()
end

_seed = 405
picture_kwargs = (
    seed=_seed,
    margin=0.2,
    ndots=60,
    ms=25,
    cluster_std=0.1,
    clip_border=true,
    m_alpha=0.2,
    generator=GravitationalGenerator(
        decision_threshold=0.95,
        opt=Descent(0.005),
    )
)

draw_small_logo(; picture_kwargs...)
draw_wide_logo(; picture_kwargs...)

const ANSI_16_FMT = `\027[%dm`

export type Styler = (text: string) -> string

const function create_styler_function(opener: number, closer: number): Styler
	const open = string.format(ANSI_16_FMT, opener)
	const close = string.format(ANSI_16_FMT, closer)

	const function styler(text: string)
		return open .. text .. close
	end

	return styler
end

const function combine_styles(style_array: { (text: string) -> string }): Styler
	const function txt(text: string)
		local result = text

		for _, style in style_array do
			result = style(result)
		end

		return result
	end

	return txt
end

const bg_colors = {
	red = create_styler_function(41, 49),
	blue = create_styler_function(44, 49),
	cyan = create_styler_function(46, 49),
	gray = create_styler_function(100, 49),
	grey = create_styler_function(100, 49),
	black = create_styler_function(40, 49),
	green = create_styler_function(42, 49),
	white = create_styler_function(47, 49),
	yellow = create_styler_function(43, 49),
	magenta = create_styler_function(45, 49),
	default = create_styler_function(49, 49),
	red_bright = create_styler_function(101, 49),
	blue_bright = create_styler_function(104, 49),
	cyan_bright = create_styler_function(106, 49),
	black_bright = create_styler_function(100, 49),
	green_bright = create_styler_function(102, 49),
	white_bright = create_styler_function(107, 49),
	yellow_bright = create_styler_function(103, 49),
	magenta_bright = create_styler_function(105, 49),
}

const modifiers = {
	dim = create_styler_function(2, 22),
	reset = create_styler_function(0, 0),
	bold = create_styler_function(1, 22),
	blink = create_styler_function(5, 25),
	italic = create_styler_function(3, 23),
	hidden = create_styler_function(8, 28),
	inverse = create_styler_function(7, 27),
	underline = create_styler_function(4, 24),
	overline = create_styler_function(53, 55),
	strikethrough = create_styler_function(9, 29),
	double_underline = create_styler_function(21, 24),
}

const txt_colors = {
	red = create_styler_function(31, 39),
	blue = create_styler_function(34, 39),
	cyan = create_styler_function(36, 39),
	gray = create_styler_function(90, 39),
	grey = create_styler_function(90, 39),
	black = create_styler_function(30, 39),
	green = create_styler_function(32, 39),
	white = create_styler_function(37, 39),
	yellow = create_styler_function(33, 39),
	magenta = create_styler_function(35, 39),
	default = create_styler_function(39, 39),
	red_bright = create_styler_function(91, 39),
	blue_bright = create_styler_function(94, 39),
	cyan_bright = create_styler_function(96, 39),
	black_bright = create_styler_function(90, 39),
	green_bright = create_styler_function(92, 39),
	white_bright = create_styler_function(97, 39),
	yellow_bright = create_styler_function(93, 39),
	magenta_bright = create_styler_function(95, 39),
}

const styles = {
	err_indicator = combine_styles({
		bg_colors.red_bright,
		modifiers.bold,
		txt_colors.white_bright,
	}),
	err_text = combine_styles({
		modifiers.bold,
		txt_colors.red_bright,
	}),

	warn_indicator = combine_styles({
		bg_colors.yellow_bright,
		modifiers.bold,
		txt_colors.white_bright,
	}),
	warn_text = combine_styles({
		modifiers.bold,
		txt_colors.yellow_bright,
	}),

	info_indicator = combine_styles({
		bg_colors.blue_bright,
		modifiers.bold,
		txt_colors.white_bright,
	}),
	info_text = combine_styles({
		txt_colors.white_bright,
	}),

	debug_indicator = combine_styles({
		bg_colors.magenta_bright,
		modifiers.bold,
		txt_colors.white_bright,
	}),
	debug_text = combine_styles({
		txt_colors.white_bright,
	}),

	success_indicator = combine_styles({
		bg_colors.green_bright,
		modifiers.bold,
		txt_colors.white_bright,
	}),
	success_text = combine_styles({
		txt_colors.white_bright,
	}),

	trace_indicator = combine_styles({
		bg_colors.black,
		modifiers.bold,
		modifiers.dim,
	}),
	trace_text = combine_styles({
		txt_colors.white_bright,
		modifiers.dim,
	}),

	keyword = combine_styles({
		txt_colors.blue_bright,
	}),

	stack_trace_indicator = combine_styles({
		modifiers.bold,
		txt_colors.white_bright,
		bg_colors.blue_bright,
	}),
	stack_trace_text = combine_styles({
		txt_colors.blue,
		modifiers.underline,
	}),
}

return {
	combine_styles = combine_styles,

	styles = styles,

	modifiers = modifiers,
	txt_colors = txt_colors,
	bg_colors = bg_colors,
}

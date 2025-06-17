local Path = require('./Path')
local types = require("./types")

export type Path = types.Path
export type AsPath = types.AsPath

return {
    Path = (Path :: any) :: {
		new: (path: string) -> types.Path,
		from: (path: types.AsPath) -> types.Path,
		is: (value: unknown) -> boolean,
	},
}

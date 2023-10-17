package.path = package.path .. ";./lua/?.lua"
package.path = package.path .. ";./lua/?/init.lua"
package.path = package.path .. ";/home/viktor/.config/nvim/lua/?.lua"

local utils = require("rust_funcs.utils")

describe("vusted", function()
	local test_data = [[use crate::Dog;

pub trait Walk {
    fn walk(&self, speed: f64) -> bool;
}




pub trait Speek {
    fn speek(noice: f64) -> bool;
}





impl Walk for Dog<f64> {
    fn walk(&self, speed: f64) -> bool {
        speed < 0.3
    }
}

impl Walk for Dog<String> {
    fn walk(&self, speed: f64) -> bool {
        speed < 0.23
    }
}






impl Speek for Dog<f64> {
    fn speek(noice : f64) -> bool {
        noice > 0.3
    }
}
]]

	it("test f", function()
		---@type Range
		local range = {
			["end"] = {
				character = 1,
				line = 27,
			},
			start = {
				character = 0,
				line = 23,
			},
		}
		local output = utils.get_lines(test_data, 23, 27)
		-- print('----------------------')
		assert(output == [[impl Walk for Dog<String> {
    fn walk(&self, speed: f64) -> bool {
        speed < 0.23
    }
}]])
	end)

	it("testo f", function()
		---@type Range
		local targetSelectionRange = {
			["end"] = {
				character = 22,
				line = 17,
			},
			start = {
				character = 14,
				line = 17,
			},
		}
		local output = utils.get_selection_range(test_data, targetSelectionRange)
		-- print(output)
		assert(output == "Dog<f64>")
	end)

	local test_data2 = [[impl Walk
    for Dog<(
        Vec<(Vec<(f32, f32)>, Dog<f32>)>,
        Vec<(Vec<(f32, f32)>, Dog<f32>)>,
        Vec<(Vec<(f32, f32)>, Dog<f32>)>,
    )>
{
    fn walk(&self, speed: f64) -> bool {
        speed < 0.3
    }
}]]

	it("test 2 ", function()
		local targetSelectionRange = {
			["end"] = {
				character = 6,
				line = 5,
			},
			start = {
				character = 8,
				line = 1,
			},
		}
		-- local output = utils.get_lines(test_data2, targetSelectionRange.start.line, targetSelectionRange["end"].line)
		local output = utils.get_selection_range(test_data2, targetSelectionRange)

		-- assert(
		-- 	output
		-- 		== "Dog<(Vec<(Vec<(f32, f32)>, Dog<f32>)>, Vec<(Vec<(f32, f32)>, Dog<f32>)>, Vec<(Vec<(f32, f32)>, Dog<f32>)>, )>"
		-- )
	end)

	local TEST_DATA3 = [[impl Walk
    for Dog<(
        Vec<(Vec<(f32, f32)>, Dog<f32>)>,
        Vec<(Vec<(f32, f32)>, Dog<f32>)>,
        Vec<(Vec<(f32, f32)>, Dog<f32>)>
    )>
{
    fn walk(&self, speed: f64) -> bool {
        speed < 0.3
    }
}]]

	it("test 3 ", function()
        print("test 3")

        local output = utils._process_impl_statement(TEST_DATA3, "Dog")

        print(output.trait)
        --
        -- print(output.trait)
	end)

    local TEST_DATA4 = [[#[cfg(not(no_global_oom_handling))]
#[cfg(test)]
impl<T> Walk for Dog<String, T> 
where
    T: Display 
{
    fn walk(&self, speed: f64) -> bool {
        speed < 0.2
    }
}
]]
--
    it("test 4", function()
        print("test 4")

        local output = utils._process_impl_statement(TEST_DATA4, "Dog")

        print("'"..output.trait.."'")

    end)

end)

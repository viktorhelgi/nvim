
local outp = {}
outp[1] = {"something", "other"}
outp[2] = {"other, other", "yes"}

for index, value in ipairs(outp) do
    print(index)
    vim.pretty_print(value)
    print("---------------")
end

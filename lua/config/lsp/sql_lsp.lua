require 'lspconfig'.sqls.setup {
    on_attach = function(_, _)
        require('lint').linters_by_ft = {
          sql = {'sql-formatter'}
        }
    end,
    filetypes = {'sql'},
    settings = {
        sqls = {
            connections = {
                {
                    driver = 'mysql',
                    -- dataSourceName = 'root:root@tcp(127.0.0.1:13306)/world',
                },
                {
                    driver = 'postgresql',
                    -- dataSourceName = 'host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable',
                },
            },
        },
    },
}

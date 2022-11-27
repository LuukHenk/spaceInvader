


local loader_class = {}

function loader_class.construct(assets_folder, assets_extension, loading_function)
    local loader = {}

    function loader.__init__()
        loader.assets_folder = assets_folder
        loader.assets_extension = assets_extension
        loader.loading_function = loading_function
    end

    function loader.load_asset(asset_name)
        local path = loader.assets_folder .. asset_name .. loader.assets_extension
        if loader.__check_if_file_exists(path) then
            return loader.loading_function(path)
        end
        print("Warning: Unable to find asset " .. path .. " for " .. asset_name)
        return nil
    end

    function loader.__check_if_file_exists(path)
        local file_data = io.open(path,"r")
        if not file_data then return false end
        io.close(file_data)
        return true
    end

    loader.__init__()
    return loader
end


return loader_class
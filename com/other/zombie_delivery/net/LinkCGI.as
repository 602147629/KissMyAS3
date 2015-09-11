class net.LinkCGI
{
    function LinkCGI()
    {
    } // End of the function
    function sendAndLoad(url, action, list)
    {
        var _loc5 = new LoadVars();
        var _loc3 = new LoadVars();
        var _loc6 = url + "?" + Math.floor(Math.random() * 10000);
        for (var _loc4 in list)
        {
            _loc3[_loc4] = list[_loc4];
        } // end of for...in
        var sc = this;
        _loc5.onLoad = function (success)
        {
            if (success == true)
            {
                sc.suc(this);
            }
            else
            {
                sc.mis();
            } // end else if
        };
        _loc3.sendAndLoad(_loc6, _loc5, action);
    } // End of the function
    function sendAndData(url, action, list)
    {
        var _loc5 = new LoadVars();
        var _loc3 = new LoadVars();
        var _loc6 = url;
        for (var _loc4 in list)
        {
            _loc3[_loc4] = list[_loc4];
        } // end of for...in
        var sc = this;
        _loc5.onData = function (data)
        {
            if (data != undefined)
            {
                sc.suc(data);
            }
            else
            {
                sc.mis();
            } // end else if
        };
        _loc3.sendAndLoad(_loc6, _loc5, action);
    } // End of the function
} // End of Class

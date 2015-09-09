class mx.xpath.NodePathInfo
{
    var __get__filter, __get__nodeName;
    function NodePathInfo(nodeName, filter)
    {
        __nodeName = nodeName;
        __filter = filter;
    } // End of the function
    function get nodeName()
    {
        return (__nodeName);
    } // End of the function
    function get filter()
    {
        return (__filter);
    } // End of the function
    var __nodeName = null;
    var __filter = null;
} // End of Class

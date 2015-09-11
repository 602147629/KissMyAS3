class mx.utils.ErrorStrings
{
    function ErrorStrings()
    {
    } // End of the function
    static function getPlayerError(code)
    {
        var _loc1 = "";
        switch (code)
        {
            case 0:
            {
                _loc1 = "Index specified is not unique";
                break;
            } 
        } // End of switch
        return (_loc1);
    } // End of the function
} // End of Class

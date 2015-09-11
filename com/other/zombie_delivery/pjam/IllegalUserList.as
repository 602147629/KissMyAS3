class pjam.IllegalUserList
{
    function IllegalUserList()
    {
    } // End of the function
    static function checkIllegal(id, name)
    {
        for (var _loc1 = 0; _loc1 < pjam.IllegalUserList.LIST.length; ++_loc1)
        {
            if (id == pjam.IllegalUserList.LIST[_loc1].id && name == pjam.IllegalUserList.LIST[_loc1].name)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static var LIST = [{id: 95, name: "sodom"}, {id: 229, name: "あるはに"}, {id: 522, name: "ben", c: "URL"}, {id: 440, name: "クロウ"}, {id: 2131, name: "ハンター"}, {id: 4643, name: "我是誰?"}, {id: 4869, name: "roof"}, {id: 4750, name: "lovel"}, {id: 5080, name: "毀月"}, {id: 1540, name: "123"}, {id: 4884, name: "楓"}, {id: 4659, name: "NEIL"}];
} // End of Class

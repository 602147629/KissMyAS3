package album
{
    import player.*;

    public class AlbumListCreate extends Object
    {

        public function AlbumListCreate()
        {
            return;
        }// end function

        public function createList(param1:Array, param2:Array) : Array
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_3:* = [];
            for each (_loc_4 in param1)
            {
                
                _loc_5 = new Object();
                _loc_6 = _loc_4;
                for each (_loc_7 in param2)
                {
                    
                    _loc_5.id = _loc_6;
                    _loc_5.bCard = false;
                    if (_loc_6 == _loc_7)
                    {
                        _loc_5.bCard = true;
                        break;
                    }
                }
                _loc_8 = PlayerManager.getInstance().getPlayerInformation(_loc_6);
                _loc_5.series = _loc_8.series;
                _loc_5.rarity = _loc_8.rarity;
                _loc_5.rarityValue = PlayerManager.getInstance().getRarityValue(_loc_8.rarity);
                _loc_5.wepon = _loc_8.weaponType;
                _loc_5.name = _loc_8.yomigana;
                _loc_3.push(_loc_5);
            }
            return _loc_3;
        }// end function

    }
}

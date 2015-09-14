package dropdownList
{
    import message.*;
    import playerList.*;

    public class DropdownTemplate extends Object
    {

        public function DropdownTemplate()
        {
            return;
        }// end function

        public static function getSeriesFilterList() : Array
        {
            return [new DropdownListData(Constant.EMPTY_ID, TextControl.formatIdText(MessageId.STORAGE_FILTER_ALL)), new DropdownListData(CommonConstant.SERIES_RS1, TextControl.formatIdText(MessageId.SERIES_NAME_RS1)), new DropdownListData(CommonConstant.SERIES_RS2, TextControl.formatIdText(MessageId.SERIES_NAME_RS2)), new DropdownListData(CommonConstant.SERIES_RS3, TextControl.formatIdText(MessageId.SERIES_NAME_RS3)), new DropdownListData(CommonConstant.SERIES_ES1, TextControl.formatIdText(MessageId.SERIES_NAME_ES1)), new DropdownListData(CommonConstant.SERIES_CL01, TextControl.formatIdText(MessageId.SERIES_NAME_CL01)), new DropdownListData(CommonConstant.SERIES_CL02, TextControl.formatIdText(MessageId.SERIES_NAME_CL02))];
        }// end function

        public static function getRarityFilterList() : Array
        {
            return [new DropdownListData(Constant.EMPTY_ID, TextControl.formatIdText(MessageId.STORAGE_FILTER_ALL)), new DropdownListData(CommonConstant.CHARACTER_RARITY_ULTLARARE, TextControl.formatIdText(MessageId.UNIT_RARITY_ULTRA_RARE)), new DropdownListData(CommonConstant.CHARACTER_RARITY_SUPERRARE, TextControl.formatIdText(MessageId.UNIT_RARITY_SUPER_RARE)), new DropdownListData(CommonConstant.CHARACTER_RARITY_PR, TextControl.formatIdText(MessageId.UNIT_RARITY_PROMOTION)), new DropdownListData(CommonConstant.CHARACTER_RARITY_RARE, TextControl.formatIdText(MessageId.UNIT_RARITY_RARE)), new DropdownListData(CommonConstant.CHARACTER_RARITY_HIGHNORMAL, TextControl.formatIdText(MessageId.UNIT_RARITY_HIGHNORMAL)), new DropdownListData(CommonConstant.CHARACTER_RARITY_NORMAL, TextControl.formatIdText(MessageId.UNIT_RARITY_NORMAL))];
        }// end function

        public static function getEmperorSelectRarityFilterList() : Array
        {
            return [new DropdownListData(Constant.EMPTY_ID, TextControl.formatIdText(MessageId.STORAGE_FILTER_ALL)), new DropdownListData(CommonConstant.CHARACTER_RARITY_ULTLARARE, TextControl.formatIdText(MessageId.UNIT_RARITY_ULTRA_RARE)), new DropdownListData(CommonConstant.CHARACTER_RARITY_SUPERRARE, TextControl.formatIdText(MessageId.UNIT_RARITY_SUPER_RARE)), new DropdownListData(CommonConstant.CHARACTER_RARITY_PR, TextControl.formatIdText(MessageId.UNIT_RARITY_PROMOTION)), new DropdownListData(CommonConstant.CHARACTER_RARITY_RARE, TextControl.formatIdText(MessageId.UNIT_RARITY_RARE))];
        }// end function

        public static function getSkillFilterList() : Array
        {
            return [new DropdownListData(Constant.EMPTY_ID, TextControl.formatIdText(MessageId.STORAGE_FILTER_ALL)), new DropdownListData(CommonConstant.CHARACTER_WEAPONTYPE_SWORD, TextControl.formatIdText(MessageId.WEAPON_TYPE_SWORD)), new DropdownListData(CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD, TextControl.formatIdText(MessageId.WEAPON_TYPE_LARGE_SWORD)), new DropdownListData(CommonConstant.CHARACTER_WEAPONTYPE_AX, TextControl.formatIdText(MessageId.WEAPON_TYPE_AX)), new DropdownListData(CommonConstant.CHARACTER_WEAPONTYPE_CLUB, TextControl.formatIdText(MessageId.WEAPON_TYPE_STICK)), new DropdownListData(CommonConstant.CHARACTER_WEAPONTYPE_SPEAR, TextControl.formatIdText(MessageId.WEAPON_TYPE_SPEAR)), new DropdownListData(CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD, TextControl.formatIdText(MessageId.WEAPON_TYPE_SMALL_SWORD)), new DropdownListData(CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS, TextControl.formatIdText(MessageId.WEAPON_TYPE_GRAPPLE)), new DropdownListData(CommonConstant.CHARACTER_WEAPONTYPE_BOW, TextControl.formatIdText(MessageId.WEAPON_TYPE_BOW))];
        }// end function

        public static function getSortList() : Array
        {
            return [new DropdownListData(ListPlayerSort.SORT_ID_NEW, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_NEW)), new DropdownListData(ListPlayerSort.SORT_ID_CHARACTER_NAME, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_CHARACTER)), new DropdownListData(ListPlayerSort.SORT_ID_RARITY, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_RARITY)), new DropdownListData(ListPlayerSort.SORT_ID_HP, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_HP)), new DropdownListData(ListPlayerSort.SORT_ID_ATTACK, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_ATTACK)), new DropdownListData(ListPlayerSort.SORT_ID_DEFENSE, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_DEFENSE)), new DropdownListData(ListPlayerSort.SORT_ID_SPEED, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_SPEED)), new DropdownListData(ListPlayerSort.SORT_ID_BATTLE_COUNT, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_BATTLE_COUNT))];
        }// end function

    }
}

package makeEquip
{
    import destinystone.*;
    import resource.*;

    public class MakeEquipConstant extends Object
    {
        public static const RESOURCE_PATH:String = ResourcePath.FACILITY_PATH + "UI_ItemCreation.swf";
        public static const RESOURCE_ANIMATION_PATH:String = ResourcePath.FACILITY_PATH + "UI_create.swf";
        public static const aTypeLabel:Array = ["", "weapon1", "weapon2", "weapon3", "protector1", "protector2", "accessory"];
        public static const aUseStone:Array = [[], [DestinyStoneId.MT_A_ORE_010, DestinyStoneId.MT_B_WOOD_010, DestinyStoneId.MT_C_FUR_010], [DestinyStoneId.MT_A_ORE_020, DestinyStoneId.MT_B_WOOD_020, DestinyStoneId.MT_C_FUR_020], [DestinyStoneId.MT_A_ORE_030, DestinyStoneId.MT_B_WOOD_030, DestinyStoneId.MT_C_FUR_030], [DestinyStoneId.MT_A_ORE_010, DestinyStoneId.MT_B_WOOD_010, DestinyStoneId.MT_C_FUR_010], [DestinyStoneId.MT_A_ORE_010, DestinyStoneId.MT_B_WOOD_010, DestinyStoneId.MT_C_FUR_010], [DestinyStoneId.MT_A_ORE_010, DestinyStoneId.MT_B_WOOD_010, DestinyStoneId.MT_C_FUR_010]];
        public static const MAX_USE_STONE:int = 50;
        public static const aMinUseStoneNum:Array = [10, 10, 10];

        public function MakeEquipConstant()
        {
            return;
        }// end function

    }
}

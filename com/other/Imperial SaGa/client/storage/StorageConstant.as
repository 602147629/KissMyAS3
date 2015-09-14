package storage
{
    import message.*;

    public class StorageConstant extends Object
    {
        public static const ITEM_FILTER_NONE:int = 0;
        public static const ITEM_FILTER_ITEM:int = 1;
        public static const ITEM_FILTER_CROWN:int = 2;
        public static const ITEM_FILTER_CHARACTER:int = 3;
        public static const ITEM_FILTER_DESTINY_STONE:int = 4;
        public static const HISTORY_LIMIT:int = 100;
        public static const ITEM_LIMIT:int = 1000;
        public static const ITEM_LIMIT_WARN:int = 900;
        public static const STORAGE_KIND_UNLIMITED_ITEM:int = 0;
        public static const STORAGE_KIND_LIMIT_ITEM:int = 1;
        public static const STORAGE_KIND_HISTORY:int = 2;
        public static const REASON_MESSAGE:Array = [Constant.UNDECIDED, MessageId.STORAGE_GET_REASON_EVENT, MessageId.STORAGE_GET_REASON_ADMIN, MessageId.STORAGE_GET_REASON_QUEST, MessageId.STORAGE_GET_REASON_PAYMENT_EMPLOYMENT, MessageId.STORAGE_GET_REASON_FREE_EMPLOYMENT, MessageId.STORAGE_GET_REASON_TRADING, MessageId.STORAGE_GET_REASON_LOGIN_BONUS, MessageId.STORAGE_GET_REASON_RUNNING_BONUS, MessageId.STORAGE_GET_REASON_MINI_PAYMENT_EVENT, MessageId.STORAGE_GET_REASON_CYCLE_COMPLETE, MessageId.STORAGE_GET_REASON_WORKSHOP_CREATE, MessageId.STORAGE_GET_REASON_CIPHER, MessageId.STORAGE_GET_REASON_EMPEROR_LEVELUP, MessageId.STORAGE_GET_REASON_LIMITED_EMPLOYMENT, MessageId.STORAGE_GET_REASON_SPECIAL_EMPLOYMENT, MessageId.STORAGE_GET_REASON_PASSWORD, MessageId.STORAGE_GET_REASON_WORKSHOP_DECOMPOSITION, MessageId.STORAGE_GET_REASON_COMEBACK_BONUS, MessageId.STORAGE_GET_REASON_DAILY_MISSION];
        public static const FILTER_MESSAGE_ID:Array = [MessageId.STORAGE_FILTER_ALL, MessageId.STORAGE_FILTER_ITEM, MessageId.STORAGE_FILTER_CROWN, MessageId.STORAGE_FILTER_CHARACTER, MessageId.STORAGE_FILTER_DESTINY_STONE];

        public function StorageConstant()
        {
            return;
        }// end function

    }
}

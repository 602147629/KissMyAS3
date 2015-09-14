package network
{

    public class NetTaskAlbumList extends NetTask
    {

        public function NetTaskAlbumList(param1:Function)
        {
            super(NetId.PROTOCOL_MYPAGE_ALBUM, param1);
            return;
        }// end function

        override public function receive(param1:NetResult) : Boolean
        {
            if (param1.resultCode == NetId.RESULT_OK)
            {
                return true;
            }
            return false;
        }// end function

    }
}

package home
{
    import flash.display.*;
    import nameEntry.*;

    public class HomeNameEntryMain extends Object
    {
        private var _nameEntry:NameEntry;
        public var _bClose:Boolean = false;

        public function HomeNameEntryMain(param1:DisplayObjectContainer)
        {
            this._nameEntry = new NameEntry(param1, this.cbNameEntry, this.cbReturn);
            this._bClose = false;
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

        public function release() : void
        {
            if (this._nameEntry)
            {
                this._nameEntry.release();
            }
            this._nameEntry = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._nameEntry)
            {
                if (this._nameEntry.bClose)
                {
                    this._bClose = true;
                }
                this._nameEntry.control(param1);
            }
            return;
        }// end function

        public function open() : void
        {
            if (this._nameEntry && !this._nameEntry.bClose)
            {
                this._bClose = false;
                this._nameEntry.setIn();
            }
            else
            {
                this.cbIn();
            }
            return;
        }// end function

        private function cbIn() : void
        {
            return;
        }// end function

        public function close() : void
        {
            if (this._nameEntry)
            {
                this._nameEntry.setOut();
            }
            return;
        }// end function

        private function cbNameEntry() : void
        {
            this.close();
            return;
        }// end function

        private function cbReturn() : void
        {
            this.close();
            return;
        }// end function

    }
}

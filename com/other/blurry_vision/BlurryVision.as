/**
http://BenSilvis.com
You may reuse this code as you please.
*/
		
package
{
	import flash.display.MovieClip;
	import flash.events.Event;
    import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.BlurFilter;
	import flash.text.TextField;
	
	public class BlurryVision extends MovieClip
	{
		public function BlurryVision()
		{			
			slider.addEventListener(Event.CHANGE, onChange);
		}

		/**
		Applys a blur filter to stage Movie Clip 'picture' based
		on the input from 'slider'
		*/
		private function onChange(e:Event):void
		{
			var blurX:Number = e.target.value; //Sets the blur value to the input from the slider
			var blurY:Number = e.target.value;
			
			var filter:BitmapFilter = new BlurFilter(blurX, blurY, BitmapFilterQuality.HIGH); //Creates a new BlurFilter
            var myFilters:Array = new Array(); //Creates an array for us to add our filters to
            myFilters.push(filter);
			
            blurredMC.filters = myFilters; //Applies all your filters to 'blurredMC'
			
			sliderTextX.text = "blurX: "+blurX;
			sliderTextY.text = "blurY: "+blurY;
		}
		
	}
}
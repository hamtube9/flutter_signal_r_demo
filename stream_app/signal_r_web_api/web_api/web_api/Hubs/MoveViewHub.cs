using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace web_api.Hubs
{
    public class MoveViewHub : Hub
    {
        public async Task MoveViewFromSever(float newX,float newY)
        {
            Console.WriteLine(newX.ToString() +" "+newY.ToString());
            await Clients.Others.SendAsync("ReceiverPosition", newX, newY);

        }


        public async Task ChangeSizeFromSever(double height, double width)
        {
            Console.WriteLine(height.ToString() + " ," + width.ToString());
            await Clients.Others.SendAsync("ReceiverSize",height,width);
        }
    }
}

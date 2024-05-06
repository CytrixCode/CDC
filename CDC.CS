using System;
using System.Drawing; 
using System.Windows.Forms; 

namespace Source
{ 
    public class Code 
    {       
        [STAThread] 
        public static void Main() 
        { 
            Application.EnableVisualStyles(); 
            Application.SetCompatibleTextRenderingDefault(false); 
            Application.Run(new Window());                  
        }
    }

    public partial class Window : Form
    {
        public Window()
        {
            Text = "Powershell CodeDom Compiler";
            Icon = new Icon(@"CDC.ico");
            Rectangle screen = Screen.FromControl(this).WorkingArea;
            StartPosition = FormStartPosition.Manual;
            ClientSize = new Size(screen.Width/2, screen.Height/2); 
            Point position = new Point(screen.X, screen.Y);
            position.Offset((screen.Width/2)-(Width/2), (screen.Height/2)-(Height/2));
            Location = position;
        }
    }
    
}
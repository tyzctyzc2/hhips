using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using System.Drawing;
using System.Drawing.Imaging;
using Microsoft.VisualBasic.PowerPacks;
using System.IO;

namespace CaptureAir
{
    class MouseCaptureHookForm : Form
    {
        private delegate IntPtr LowLevelMouseProc(int nCode, IntPtr wParam, IntPtr lParam);

        LowLevelMouseProc myHookProcedure = myHookMouseProc;
        static IntPtr hook;
        public static bool inCapture = false;

        static POINT startPOS;
        static POINT endPOS;
        static POINT curPOS;

        static MouseCaptureHookForm myPreviewForm;
        static PictureBox myPreviewImg;
        Label labelVerticalAxis;
        Label labelHorizontalAxis;

        public static Bitmap lastCapturedPic;

        public delegate void CaptureIsDone();
        public static CaptureIsDone myCaptureDone;

        String capturedPic;

        static private String GetMyPath()
        {
            System.Diagnostics.Debug.WriteLine(System.IO.Path.GetDirectoryName(Application.ExecutablePath));
            return System.IO.Path.GetDirectoryName(Application.ExecutablePath);
        }

        public String GetCapturedImage()
        {
            if (capturedPic.Length == 0)
                return "";

            using (Image image = Image.FromFile(capturedPic))
            {
                using (MemoryStream m = new MemoryStream())
                {
                    image.Save(m, image.RawFormat);
                    byte[] imageBytes = m.ToArray();

                    // Convert byte[] to Base64 String
                    string base64String = Convert.ToBase64String(imageBytes);
                    return base64String;
                }
            }   
        }

        public MouseCaptureHookForm()
        {
            this.FormBorderStyle = FormBorderStyle.None;
            this.WindowState = FormWindowState.Maximized;
            this.TopMost = true;
            this.KeyDown += new KeyEventHandler(myPreviewForm_KeyDown);
            this.Cursor = Cursors.Cross;

            myPreviewForm = this;
        }

        void myPreviewForm_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape)
            {
                lastCapturedPic = null;
                StopCapture();
            }
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            base.OnPaint(e);

            labelVerticalAxis.Location = new Point(curPOS.x, curPOS.y - axisSize/2);
            labelHorizontalAxis.Location = new Point(curPOS.x-axisSize/2, curPOS.y);
            labelVerticalAxis.BringToFront();
            labelHorizontalAxis.BringToFront();
        }

        const int axisSize = 2000;
        public void StartCapture()
        {
            //hook mouse
            hook = SetWindowsHookEx(WH_MOUSE_LL, myHookProcedure, GetModuleHandle("user32"), 0);
            if (hook == IntPtr.Zero) throw new System.ComponentModel.Win32Exception();

            System.Threading.Thread.Sleep(500);

            try
            {
                System.Console.WriteLine("start capture");
                Bitmap captureBitmap = new Bitmap(Screen.PrimaryScreen.WorkingArea.Width, Screen.PrimaryScreen.WorkingArea.Height, PixelFormat.Format32bppArgb);

                Rectangle captureRectangle = Screen.AllScreens[0].Bounds;
                //Creating a New Graphics Object

                Graphics captureGraphics = Graphics.FromImage(captureBitmap);

                captureGraphics.CopyFromScreen(captureRectangle.Left, captureRectangle.Top, 0, 0, captureRectangle.Size);
                //Saving the Image File (I am here Saving it in My E drive).

                captureBitmap.Save(GetMyPath() + @"\full_s.jpg", ImageFormat.Png);

                myPreviewImg = new PictureBox();

                myPreviewImg = new PictureBox
                {
                    Name = "pictureBox",
                    Size = new Size(Screen.PrimaryScreen.WorkingArea.Width, Screen.PrimaryScreen.WorkingArea.Height),
                    Location = new Point(0, 0),
                    Image = Image.FromFile(GetMyPath() + @"\full_s.jpg")
                };
                
                this.Controls.Add(myPreviewImg);

                labelVerticalAxis = new Label();
                labelVerticalAxis.BackColor = Color.Black;
                labelVerticalAxis.Location = new Point(0, 0);
                labelVerticalAxis.Size = new Size(1, axisSize);
                this.Controls.Add(labelVerticalAxis);
                labelVerticalAxis.BringToFront();

                labelHorizontalAxis = new Label();
                labelHorizontalAxis.BackColor = Color.Black;
                labelHorizontalAxis.Location = new Point(0, 0);
                labelHorizontalAxis.Size = new Size(axisSize, 1);
                this.Controls.Add(labelHorizontalAxis);
                labelHorizontalAxis.BringToFront();

            }

            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);

            }

            myPreviewForm.capturedPic = "";
            this.Show();
            Invalidate();
        }
        public static void StopCapture()
        {
            myPreviewForm.Hide();
            UnhookWindowsHookEx(hook);

            myPreviewImg.Image.Dispose();
            myPreviewForm.Controls.Clear();
            myCaptureDone();
            
        }

        private static IntPtr myHookMouseProc(int nCode, IntPtr wParam, IntPtr lParam)
        {
            if (nCode >= 0 && MouseMessages.WM_LBUTTONDOWN == (MouseMessages)wParam)
            {
                MSLLHOOKSTRUCT hookStruct = (MSLLHOOKSTRUCT)Marshal.PtrToStructure(lParam, typeof(MSLLHOOKSTRUCT));
                inCapture = true;
                startPOS = hookStruct.pt;

                System.Console.WriteLine("myHookMouseProc start capture " + nCode + "--" + startPOS.x.ToString() + "," + startPOS.y.ToString());

            }
            else if (nCode >= 0 && MouseMessages.WM_LBUTTONUP == (MouseMessages)wParam)
            {
                MSLLHOOKSTRUCT hookStruct = (MSLLHOOKSTRUCT)Marshal.PtrToStructure(lParam, typeof(MSLLHOOKSTRUCT));
                inCapture = false;
                endPOS = hookStruct.pt;

                System.Console.WriteLine("myHookMouseProc end capture " + nCode + "--" + endPOS.x.ToString() + "," + endPOS.y.ToString());

                DoCapture();
                StopCapture();
            }
            else if (nCode >= 0 && MouseMessages.WM_MOUSEMOVE == (MouseMessages)wParam)
            {
                MSLLHOOKSTRUCT hookStruct = (MSLLHOOKSTRUCT)Marshal.PtrToStructure(lParam, typeof(MSLLHOOKSTRUCT));
                curPOS = hookStruct.pt;
                myPreviewForm.Invalidate();
            }

            return CallNextHookEx(hook, 1, wParam, lParam);
        }

        private static void DoCapture()
        {
            int width = Math.Abs(startPOS.x - endPOS.x);
            int height = Math.Abs(startPOS.y - endPOS.y);

            int startX = Math.Min(startPOS.x, endPOS.x);
            int startY = Math.Min(startPOS.y, endPOS.y);

            if ((width < 10) || (height < 10))
            {
                return;
            }

            System.Console.WriteLine("capture size = " + width + "h=" + height);

            try
            {

                //Creating a new Bitmap object

                Bitmap captureBitmap = new Bitmap(width, height, PixelFormat.Format32bppArgb);


                Rectangle captureRectangle = Screen.AllScreens[0].Bounds;

                Graphics captureGraphics = Graphics.FromImage(captureBitmap);

                captureGraphics.CopyFromScreen(startX, startY, 0, 0, new Size(width, height));

                captureBitmap.Save(GetMyPath() + @"\Capture.png", ImageFormat.Png);
                lastCapturedPic = captureBitmap;

                myPreviewForm.capturedPic = GetMyPath() + @"\Capture.png";

            }

            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);

            }

        }

        private const int WH_MOUSE_LL = 14;

        private enum MouseMessages
        {
            WM_LBUTTONDOWN = 0x0201,
            WM_LBUTTONUP = 0x0202,
            WM_MOUSEMOVE = 0x0200,
            WM_MOUSEWHEEL = 0x020A,
            WM_RBUTTONDOWN = 0x0204,
            WM_RBUTTONUP = 0x0205
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct POINT
        {
            public int x;
            public int y;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct MSLLHOOKSTRUCT
        {
            public POINT pt;
            public uint mouseData;
            public uint flags;
            public uint time;
            public IntPtr dwExtraInfo;
        }

        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern IntPtr SetWindowsHookEx(int idHook,
          LowLevelMouseProc lpfn, IntPtr hMod, uint dwThreadId);

        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        private static extern bool UnhookWindowsHookEx(IntPtr hhk);

        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern IntPtr CallNextHookEx(IntPtr hhk, int nCode,
          IntPtr wParam, IntPtr lParam);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern IntPtr GetModuleHandle(string lpModuleName);


    }
}

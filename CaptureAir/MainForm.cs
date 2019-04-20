using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;

namespace CaptureAir
{
    public partial class MainForm : Form
    {
        enum CaptureStatus { CAPTURE_NOT, CAPTURE_PROBLEM, CAPTURE_PROBLEM_PLUS, CAPTURE_ANSWER, CPATURE_ANSWER_PLUS, CAPTURE_PROBLEMB, CAPTURE_PROBLEMB_PLUS, CAPTURE_PROBLEMC, CAPTURE_PROBLEMC_PLUS };
        CaptureStatus myCaptureStatus = CaptureStatus.CAPTURE_NOT;

        Color defaultColor;

        MouseCaptureHookForm myCaptureForm = new MouseCaptureHookForm();
        PreviewImgForm myPreviewForm = new PreviewImgForm();

        ProblemSubmitter mySubmitter = new ProblemSubmitter();

        List<Bitmap> myProblemPartBitmap = new List<Bitmap>();
        List<Bitmap> myProblembPartBitmap = new List<Bitmap>();
        List<Bitmap> myProblemcPartBitmap = new List<Bitmap>();
        List<Bitmap> myAnswerPartBitmap = new List<Bitmap>();

        //shortcut
        private const int WH_KEYBOARD_LL = 13;
        private const int WM_KEYDOWN = 0x0100;
        private delegate IntPtr LowLevelMouseProc(int nCode, IntPtr wParam, IntPtr lParam);

        LowLevelMouseProc myHookProcedure = myHookKeyProc;
        static IntPtr hook;
        static MainForm myMainWin;
        static int myLastKeyPressed = 0;
        Timer myTimerInSecond;

        public MainForm()
        {
            this.components = new System.ComponentModel.Container();
            InitializeComponent();

            int x = Screen.PrimaryScreen.WorkingArea.Right - 200;
            int y = Screen.PrimaryScreen.WorkingArea.Bottom - 500;

            this.StartPosition = FormStartPosition.Manual;
            this.Location = new Point(x, y);

            this.TopMost = true;
            defaultColor = button_problem.BackColor;

            MouseCaptureHookForm.myCaptureDone = afterCaptureDone;

            comboBox_module.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBox_index.DropDownStyle = ComboBoxStyle.DropDownList;

            comboBox_module.Items.Add("1-计算");
            comboBox_module.Items.Add("2-计数");
            comboBox_module.Items.Add("3-应用题");
            comboBox_module.Items.Add("4-几何");
            comboBox_module.Items.Add("5-逻辑");
            comboBox_module.Items.Add("6-数论");
            comboBox_module.Items.Add("10-语文");
            comboBox_module.Items.Add("20-english");
            comboBox_module.SelectedIndex = 0;

            for (int i = 1; i < 9; ++i)
            {
                comboBox_index.Items.Add("L"+i.ToString());
                comboBox_index.Items.Add("L" + i.ToString()+"L");
            }

            for (int i = 1; i < 41; ++i)
            {
                comboBox_index.Items.Add(i.ToString().PadLeft(2, '0'));
            }

            for (int i = 1; i < 15; ++i)
            {
                comboBox_index.Items.Add("T" + i.ToString().PadLeft(2, '0'));
            }

            for (int i = 1; i < 7; ++i)
            {
                comboBox_index.Items.Add("J" + i.ToString().PadLeft(2, '0'));
            }

            for (int i = 1; i < 9; ++i)
            {
                comboBox_index.Items.Add("C" + i.ToString().PadLeft(2, '0'));
            }

            for (int i = 1; i < 11; ++i)
            {
                comboBox_index.Items.Add("Z" + i.ToString().PadLeft(2, '0'));
            }

            comboBox_index.SelectedIndex = 0;

            IniSubmitter();

            buttonReview.MouseEnter += new EventHandler(buttonReview_MouseEnter);
            buttonReview.MouseLeave += new EventHandler(buttonReview_MouseLeave);

            hook = SetWindowsHookEx(WH_KEYBOARD_LL, myHookProcedure, GetModuleHandle("user32"), 0);
            if (hook == IntPtr.Zero) throw new System.ComponentModel.Win32Exception();

            myTimerInSecond = new Timer();
            myTimerInSecond.Interval = 1000;
            myTimerInSecond.Tick += new EventHandler(myTimerInSecond_Tick);
            myTimerInSecond.Start();

            myMainWin = this;

        }

        void myTimerInSecond_Tick(object sender, EventArgs e)
        {
            if (MainForm.myLastKeyPressed == 0)
                return;

            switch (MainForm.myLastKeyPressed)
            {
                case '1':
                    myMainWin.button_problem_Click(null, null);
                    break;
                case '2':
                    myMainWin.button_problem_plus_Click(null, null);
                    break;
                case '3':
                    myMainWin.button_problemb_Click(null, null);
                    break;
                case '4':
                    myMainWin.button_problemb_plus_Click(null, null);
                    break;
                case '5':
                    myMainWin.button_problemc_Click(null, null);
                    break;
                case '6':
                    myMainWin.button_problemc_plus_Click(null, null);
                    break;
                case 'Q':
                    myMainWin.button_answer_Click(null, null);
                    break;
                case 'W':
                    myMainWin.button_answer_plus_Click(null, null);
                    break;
                case 'E':
                    myMainWin.button_submit_Click(null, null);
                    break;
                case 'R':
                    myMainWin.button_update_Click(null, null);
                    break;
                default:
                    break;
            }
            MainForm.myLastKeyPressed = 0;
        }

        private static IntPtr myHookKeyProc(int nCode, IntPtr wParam, IntPtr lParam)
        {
            Console.WriteLine("some key was pressed");
            if (nCode >= 0 && wParam == (IntPtr)WM_KEYDOWN)
            {
                int vkCode = System.Runtime.InteropServices.Marshal.ReadInt32(lParam);
                myLastKeyPressed = vkCode;
            }

            return CallNextHookEx(hook, nCode, wParam, lParam);
        }

        void buttonReview_MouseLeave(object sender, EventArgs e)
        {
            this.myPreviewForm.Hide();
        }

        void buttonReview_MouseEnter(object sender, EventArgs e)
        {
            this.myPreviewForm.Show();
        }

        private void IniSubmitter()
        {
            radioButton2.Checked = true;
            mySubmitter.problemlevel = GetLevel();
        }

        int GetLevel()
        {
            if (radioButton1.Checked)
                return 1;
            else if (radioButton2.Checked)
                return 2;
            else if (radioButton3.Checked)
                return 3;
            else
                return 4;
        }

        private void button_index_add_Click(object sender, EventArgs e)
        {
            int ii = this.comboBox_index.SelectedIndex;

            ii++;
            try
            {
                this.comboBox_index.SelectedIndex = ii;
            }
            catch
            {
            }
        }

        private void button_index_sub_Click(object sender, EventArgs e)
        {
            int ii = this.comboBox_index.SelectedIndex;

            ii--;
            if (ii > -1)
                this.comboBox_index.SelectedIndex = ii;
        }

        private void button_chapterid_add_Click(object sender, EventArgs e)
        {
            string tt = this.textBoxChapterID.Text;
            try
            {
                int ii = Int32.Parse(tt);
                if (ii > 0)
                {
                    ii++;
                    this.textBoxChapterID.Text = ii.ToString();
                }
            }
            catch
            {
            }
        }

        private void button_chapterid_sub_Click(object sender, EventArgs e)
        {
            string tt = this.textBoxChapterID.Text;
            try
            {
                int ii = Int32.Parse(tt);
                if (ii > 0)
                {
                    ii--;
                    this.textBoxChapterID.Text = ii.ToString();
                }
            }
            catch
            {
            }
        }  

        void afterCaptureDone()
        {
            this.Show();
            System.Console.WriteLine("capture is done!");
            this.Visible = true;
            this.Show();

            CollectCaptureData();

            ResetCapture();
        }

        private void CollectCaptureData()
        {
            string img = myCaptureForm.GetCapturedImage();
            if (img.Length == 0)
                return;

            switch (myCaptureStatus)
            {
                case CaptureStatus.CAPTURE_ANSWER:
                    mySubmitter.problemanswerdetail = img;
                    this.myPreviewForm.SetPictureB(MouseCaptureHookForm.lastCapturedPic);
                    myAnswerPartBitmap.Clear();
                    myAnswerPartBitmap.Add(MouseCaptureHookForm.lastCapturedPic);
                    break;
                case CaptureStatus.CPATURE_ANSWER_PLUS:
                    myAnswerPartBitmap.Add(MouseCaptureHookForm.lastCapturedPic);
                    this.myPreviewForm.SetPictureB(MergeBitmap(myAnswerPartBitmap));
                    break;
                case CaptureStatus.CAPTURE_PROBLEM:
                    mySubmitter.problemdetail = img;
                    this.myPreviewForm.SetPictureA(MouseCaptureHookForm.lastCapturedPic);
                    myProblemPartBitmap.Clear();
                    myProblemPartBitmap.Add(MouseCaptureHookForm.lastCapturedPic);
                    break;
                case CaptureStatus.CAPTURE_PROBLEM_PLUS:
                    myProblemPartBitmap.Add(MouseCaptureHookForm.lastCapturedPic);
                    myPreviewForm.SetPictureA(MergeBitmap(myProblemPartBitmap));
                    break;
                case CaptureStatus.CAPTURE_PROBLEMB:
                    mySubmitter.problemdetailb = img;
                    this.myPreviewForm.SetPictureA2(MouseCaptureHookForm.lastCapturedPic);
                    myProblembPartBitmap.Clear();
                    myProblembPartBitmap.Add(MouseCaptureHookForm.lastCapturedPic);
                    break;
                case CaptureStatus.CAPTURE_PROBLEMB_PLUS:
                    myProblembPartBitmap.Add(MouseCaptureHookForm.lastCapturedPic);
                    myPreviewForm.SetPictureA2(MergeBitmap(myProblembPartBitmap));
                    break;
                case CaptureStatus.CAPTURE_PROBLEMC:
                    mySubmitter.problemdetailc = img;
                    this.myPreviewForm.SetPictureA3(MouseCaptureHookForm.lastCapturedPic);
                    myProblemcPartBitmap.Clear();
                    myProblemcPartBitmap.Add(MouseCaptureHookForm.lastCapturedPic);
                    break;
                case CaptureStatus.CAPTURE_PROBLEMC_PLUS:
                    myProblemcPartBitmap.Add(MouseCaptureHookForm.lastCapturedPic);
                    myPreviewForm.SetPictureA3(MergeBitmap(myProblemcPartBitmap));
                    break;
                default:
                    return;
            }
        }

        private Bitmap MergeBitmap(List<Bitmap> wantMerge)
        {
            const int maxLineWidth = 1400;
            int newWidth = 0;
            int newHeight = 0;
            List<Bitmap> partBitmap = new List<Bitmap>();
            List<Rectangle> partPos = new List<Rectangle>();

            Rectangle curPos = new Rectangle();
            int curLineWidth = 0;
            int curLineHeight = wantMerge[0].Height;
            for (int i = 0; i < wantMerge.Count; ++i)
            {
                Bitmap curBitmap = wantMerge[i];

                if ((curLineWidth + curBitmap.Width) < maxLineWidth)
                {//this line
                    curLineWidth = curLineWidth + curBitmap.Width;
                }
                else
                {//start new line
                    curPos = new Rectangle(0, newHeight + curLineHeight, 0, 0);
                    newHeight = newHeight + curLineHeight;
                    curLineWidth = curBitmap.Width;
                    curLineHeight = curBitmap.Height;
                    
                }

                if (curLineWidth > newWidth)
                    newWidth = curLineWidth;

                if (curBitmap.Height > curLineHeight)
                    curLineHeight = curBitmap.Height;

                curPos.Width = curBitmap.Width;
                curPos.Height = curBitmap.Height;
                partBitmap.Add(curBitmap);
                partPos.Add(curPos);

                curPos = new Rectangle(curPos.Left + curBitmap.Width, curPos.Top, 0, 0);

            }

            newHeight = newHeight + curLineHeight;

            Bitmap finalBitmap = new Bitmap(newWidth, newHeight);
            using (System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(finalBitmap))
            {
                //set background color
                g.Clear(System.Drawing.Color.White);

                //go through each image and draw it on the final image
                for (int i = 0; i < partBitmap.Count; ++i)
                {
                    Bitmap curImg = partBitmap[i];
                    g.DrawImage(curImg, partPos[i]);
                }
            }

            return finalBitmap;
        }

        private void ResetCapture()
        {
            StopCapture(button_answer);
            StopCapture(button_answer_plus);
            StopCapture(button_problem);
            StopCapture(button_problem_plus);
            StopCapture(button_problemb);
            StopCapture(button_problemb_plus);
            StopCapture(button_problemc);
            StopCapture(button_problemc_plus);
        }
   
        private void StartCapture(Button _button, CaptureStatus captureStatus)
        {
            myCaptureStatus = captureStatus;
            _button.BackColor = Color.LightBlue;

            this.Visible = false;
            this.Hide();
            this.Invalidate();

            System.Console.WriteLine("hide main form");
            myCaptureForm.StartCapture();
        }

        private void StopCapture(Button _button)
        {
            myCaptureStatus = CaptureStatus.CAPTURE_NOT;
            _button.BackColor = defaultColor;
            button_copyP_Click(null, null);
        }

        private void button_problem_Click(object sender, EventArgs e)
        {
            if (myCaptureStatus == CaptureStatus.CAPTURE_NOT)
            {
                StartCapture(button_problem, CaptureStatus.CAPTURE_PROBLEM);
            }
            else if (myCaptureStatus == CaptureStatus.CAPTURE_PROBLEM)
            {
                StopCapture(button_problem);
            }
        }

        private void button_problem_plus_Click(object sender, EventArgs e)
        {
            if (myCaptureStatus == CaptureStatus.CAPTURE_NOT)
            {
                StartCapture(button_problem_plus, CaptureStatus.CAPTURE_PROBLEM_PLUS);
            }
            else if (myCaptureStatus == CaptureStatus.CAPTURE_PROBLEM_PLUS)
            {
                StopCapture(button_problem_plus);
            }
        }

        private void button_problemb_Click(object sender, EventArgs e)
        {
            if (myCaptureStatus == CaptureStatus.CAPTURE_NOT)
            {
                StartCapture(button_problemb, CaptureStatus.CAPTURE_PROBLEMB);
            }
            else if (myCaptureStatus == CaptureStatus.CAPTURE_PROBLEMB)
            {
                StopCapture(button_problemb);
            }
        }

        private void button_problemb_plus_Click(object sender, EventArgs e)
        {
            if (myCaptureStatus == CaptureStatus.CAPTURE_NOT)
            {
                StartCapture(button_problemb_plus, CaptureStatus.CAPTURE_PROBLEMB_PLUS);
            }
            else if (myCaptureStatus == CaptureStatus.CAPTURE_PROBLEMB_PLUS)
            {
                StopCapture(button_problemb_plus);
            }
        }

        private void button_problemc_Click(object sender, EventArgs e)
        {
            if (myCaptureStatus == CaptureStatus.CAPTURE_NOT)
            {
                StartCapture(button_problemc, CaptureStatus.CAPTURE_PROBLEMC);
            }
            else if (myCaptureStatus == CaptureStatus.CAPTURE_PROBLEMC)
            {
                StopCapture(button_problemc);
            }
        }

        private void button_problemc_plus_Click(object sender, EventArgs e)
        {
            if (myCaptureStatus == CaptureStatus.CAPTURE_NOT)
            {
                StartCapture(button_problemc_plus, CaptureStatus.CAPTURE_PROBLEMC_PLUS);
            }
            else if (myCaptureStatus == CaptureStatus.CAPTURE_PROBLEMC_PLUS)
            {
                StopCapture(button_problemc_plus);
            }
        }    

        private void button_answer_Click(object sender, EventArgs e)
        {
            if (myCaptureStatus == CaptureStatus.CAPTURE_NOT)
            {
                StartCapture(button_answer, CaptureStatus.CAPTURE_ANSWER);
            }
            else if (myCaptureStatus == CaptureStatus.CAPTURE_ANSWER)
            {
                StopCapture(button_answer);
            }
        }

        private void button_answer_plus_Click(object sender, EventArgs e)
        {
            if (myCaptureStatus == CaptureStatus.CAPTURE_NOT)
            {
                StartCapture(button_answer_plus, CaptureStatus.CPATURE_ANSWER_PLUS);
            }
            else if (myCaptureStatus == CaptureStatus.CPATURE_ANSWER_PLUS)
            {
                StopCapture(button_answer_plus);
            }
        }

        private void button_update_Click(object sender, EventArgs e)
        {
            grabData();

            mySubmitter.idproblem = this.textBox_idproblem.Text;
            
            string ip = this.textBoxIP.Text;
            System.Diagnostics.Debug.WriteLine(ip);

            if (mySubmitter.Update(ip) == true)
            {
                var item = new NotifyIcon(this.components);
                item.Visible = true;
                item.Icon = System.Drawing.SystemIcons.Information;
                item.ShowBalloonTip(3000, "Problem updated!", "Problem updated!", ToolTipIcon.Info);

                //reset all for next submit
                mySubmitter = new ProblemSubmitter();
            }

        }

        private void button_submit_Click(object sender, EventArgs e)
        {
            grabData();

            if (mySubmitter.problemanswerdetail == null)
            {
                MessageBox.Show("No problem answer image!");
                return;
            }

            if (mySubmitter.problemdetail == null)
            {
                MessageBox.Show("No problem image!");
                return;
            }

            string ip = this.textBoxIP.Text;
            System.Diagnostics.Debug.WriteLine(ip);

            if (mySubmitter.Submit(ip) == true)
            {
                var item = new NotifyIcon(this.components);
                item.Visible = true;
                item.Icon = System.Drawing.SystemIcons.Information;
                item.ShowBalloonTip(3000, "Problem created!", "Problem created!", ToolTipIcon.Info);

                try
                {
                    comboBox_index.SelectedIndex = comboBox_index.SelectedIndex + 1;
                }
                catch (Exception)
                {
                    
                }

                //reset all for next submit
                mySubmitter = new ProblemSubmitter();
            }

        }

        private void grabData()
        {
            //grab value first
            int pos = comboBox_module.SelectedItem.ToString().IndexOf("-");
            string module = comboBox_module.SelectedItem.ToString().Substring(0, pos);
            mySubmitter.problemmodule = module;
            mySubmitter.problemlevel = GetLevel();
            mySubmitter.problemindex = comboBox_index.SelectedItem.ToString();
            mySubmitter.problemchapterid = this.textBoxChapterID.Text;
            mySubmitter.problemdetail = myPreviewForm.GetPictureAString();
            mySubmitter.problemdetailb = myPreviewForm.GetPictureA2String();
            mySubmitter.problemdetailc = myPreviewForm.GetPictureA3String();
            mySubmitter.problemanswerdetail = myPreviewForm.GetPictureBString();
        }

        private void button_reset_Click(object sender, EventArgs e)
        {
            this.myPreviewForm.SetPictureA(null);
            this.myPreviewForm.SetPictureB(null);
            this.myPreviewForm.SetPictureA2(null);
            this.myPreviewForm.SetPictureA3(null);
        }

        private void button_copyP_Click(object sender, EventArgs e)
        {
            Clipboard.SetImage(myPreviewForm.GetPictureA());
        }

        private void button_copyA_Click(object sender, EventArgs e)
        {
            Clipboard.SetImage(myPreviewForm.GetPictureB());
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

        [DllImport("kernel32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool AllocConsole();        
    }
}

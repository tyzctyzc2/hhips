using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace CaptureAir
{
    public partial class PreviewImgForm : Form
    {
        public PreviewImgForm()
        {
            InitializeComponent();
        }

        public void SetPictureA(Bitmap _b)
        {
            pictureBoxA.Image = _b;
        }

        public void SetPictureB(Bitmap _b)
        {
            pictureBoxB.Image = _b;
        }

        public void ResetPicture()
        {
            pictureBoxA.Image = null;
            pictureBoxB.Image = null;
        }

        public string GetPictureAString()
        {
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                this.pictureBoxA.Image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] byteImage = ms.ToArray();
                return Convert.ToBase64String(ms.GetBuffer());
            }
        }

        public string GetPictureBString()
        {
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                this.pictureBoxB.Image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] byteImage = ms.ToArray();
                return Convert.ToBase64String(ms.GetBuffer());
            }
        }
    }
}

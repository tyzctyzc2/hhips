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

        public void SetPictureA2(Bitmap _b)
        {
            pictureBoxA2.Image = _b;
        }

        public void SetPictureA3(Bitmap _b)
        {
            pictureBoxA3.Image = _b;
        }

        public Image GetPictureA()
        {
            return pictureBoxA.Image;
        }

        public Image GetPictureA2()
        {
            return pictureBoxA2.Image;
        }

        public Image GetPictureA3()
        {
            return pictureBoxA3.Image;
        }

        public Image GetPictureB()
        {
            return pictureBoxB.Image;
        }

        public void ResetPicture()
        {
            pictureBoxA.Image = null;
            pictureBoxB.Image = null;
            pictureBoxA2.Image = null;
            pictureBoxA3.Image = null;
        }

        public string GetPictureAString()
        {
            if (this.pictureBoxA.Image == null)
                return "";
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                this.pictureBoxA.Image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] byteImage = ms.ToArray();
                return Convert.ToBase64String(ms.GetBuffer());
            }
        }

        public string GetPictureA2String()
        {
            if (pictureBoxA2.Image == null)
                return "";
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                this.pictureBoxA2.Image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] byteImage = ms.ToArray();
                return Convert.ToBase64String(ms.GetBuffer());
            }
        }

        public string GetPictureA3String()
        {
            if (pictureBoxA3.Image == null)
                return "";
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                this.pictureBoxA2.Image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] byteImage = ms.ToArray();
                return Convert.ToBase64String(ms.GetBuffer());
            }
        }

        public string GetPictureBString()
        {
            if (this.pictureBoxB.Image == null)
                return "";
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                this.pictureBoxB.Image.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] byteImage = ms.ToArray();
                return Convert.ToBase64String(ms.GetBuffer());
            }
        }
    }
}

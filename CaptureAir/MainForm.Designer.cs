namespace CaptureAir
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.comboBox_module = new System.Windows.Forms.ComboBox();
            this.button_problem = new System.Windows.Forms.Button();
            this.button_problem_plus = new System.Windows.Forms.Button();
            this.button_answer_plus = new System.Windows.Forms.Button();
            this.button_answer = new System.Windows.Forms.Button();
            this.button_submit = new System.Windows.Forms.Button();
            this.comboBox_index = new System.Windows.Forms.ComboBox();
            this.buttonReview = new System.Windows.Forms.Button();
            this.textBoxChapterID = new System.Windows.Forms.TextBox();
            this.textBoxIP = new System.Windows.Forms.TextBox();
            this.radioButton1 = new System.Windows.Forms.RadioButton();
            this.groupBoxLevel = new System.Windows.Forms.GroupBox();
            this.radioButton4 = new System.Windows.Forms.RadioButton();
            this.radioButton3 = new System.Windows.Forms.RadioButton();
            this.radioButton2 = new System.Windows.Forms.RadioButton();
            this.button_copyP = new System.Windows.Forms.Button();
            this.button_problemb = new System.Windows.Forms.Button();
            this.button_problemc = new System.Windows.Forms.Button();
            this.button_problemb_plus = new System.Windows.Forms.Button();
            this.button_problemc_plus = new System.Windows.Forms.Button();
            this.button_chapterid_add = new System.Windows.Forms.Button();
            this.button_chapterid_sub = new System.Windows.Forms.Button();
            this.button_index_sub = new System.Windows.Forms.Button();
            this.button_index_add = new System.Windows.Forms.Button();
            this.button_reset = new System.Windows.Forms.Button();
            this.button_update = new System.Windows.Forms.Button();
            this.textBox_idproblem = new System.Windows.Forms.TextBox();
            this.groupBoxLevel.SuspendLayout();
            this.SuspendLayout();
            // 
            // comboBox_module
            // 
            this.comboBox_module.FormattingEnabled = true;
            this.comboBox_module.Location = new System.Drawing.Point(4, 12);
            this.comboBox_module.Name = "comboBox_module";
            this.comboBox_module.Size = new System.Drawing.Size(57, 21);
            this.comboBox_module.TabIndex = 0;
            // 
            // button_problem
            // 
            this.button_problem.Location = new System.Drawing.Point(4, 166);
            this.button_problem.Name = "button_problem";
            this.button_problem.Size = new System.Drawing.Size(39, 50);
            this.button_problem.TabIndex = 1;
            this.button_problem.Text = "P-1";
            this.button_problem.UseVisualStyleBackColor = true;
            this.button_problem.Click += new System.EventHandler(this.button_problem_Click);
            // 
            // button_problem_plus
            // 
            this.button_problem_plus.Location = new System.Drawing.Point(49, 166);
            this.button_problem_plus.Name = "button_problem_plus";
            this.button_problem_plus.Size = new System.Drawing.Size(44, 50);
            this.button_problem_plus.TabIndex = 2;
            this.button_problem_plus.Text = "+ 2";
            this.button_problem_plus.UseVisualStyleBackColor = true;
            this.button_problem_plus.Click += new System.EventHandler(this.button_problem_plus_Click);
            // 
            // button_answer_plus
            // 
            this.button_answer_plus.Location = new System.Drawing.Point(49, 222);
            this.button_answer_plus.Name = "button_answer_plus";
            this.button_answer_plus.Size = new System.Drawing.Size(44, 50);
            this.button_answer_plus.TabIndex = 4;
            this.button_answer_plus.Text = "+ (W)";
            this.button_answer_plus.UseVisualStyleBackColor = true;
            this.button_answer_plus.Click += new System.EventHandler(this.button_answer_plus_Click);
            // 
            // button_answer
            // 
            this.button_answer.Location = new System.Drawing.Point(4, 222);
            this.button_answer.Name = "button_answer";
            this.button_answer.Size = new System.Drawing.Size(39, 50);
            this.button_answer.TabIndex = 3;
            this.button_answer.Text = "A (Q)";
            this.button_answer.UseVisualStyleBackColor = true;
            this.button_answer.Click += new System.EventHandler(this.button_answer_Click);
            // 
            // button_submit
            // 
            this.button_submit.Location = new System.Drawing.Point(57, 113);
            this.button_submit.Name = "button_submit";
            this.button_submit.Size = new System.Drawing.Size(42, 47);
            this.button_submit.TabIndex = 5;
            this.button_submit.Text = "Save  (E)";
            this.button_submit.UseVisualStyleBackColor = true;
            this.button_submit.Click += new System.EventHandler(this.button_submit_Click);
            // 
            // comboBox_index
            // 
            this.comboBox_index.FormattingEnabled = true;
            this.comboBox_index.Location = new System.Drawing.Point(80, 12);
            this.comboBox_index.Name = "comboBox_index";
            this.comboBox_index.Size = new System.Drawing.Size(42, 21);
            this.comboBox_index.TabIndex = 7;
            // 
            // buttonReview
            // 
            this.buttonReview.Location = new System.Drawing.Point(4, 113);
            this.buttonReview.Name = "buttonReview";
            this.buttonReview.Size = new System.Drawing.Size(52, 47);
            this.buttonReview.TabIndex = 9;
            this.buttonReview.Text = "Review";
            this.buttonReview.UseVisualStyleBackColor = true;
            // 
            // textBoxChapterID
            // 
            this.textBoxChapterID.Location = new System.Drawing.Point(24, 39);
            this.textBoxChapterID.Name = "textBoxChapterID";
            this.textBoxChapterID.Size = new System.Drawing.Size(37, 20);
            this.textBoxChapterID.TabIndex = 10;
            // 
            // textBoxIP
            // 
            this.textBoxIP.Location = new System.Drawing.Point(91, 39);
            this.textBoxIP.Name = "textBoxIP";
            this.textBoxIP.Size = new System.Drawing.Size(50, 20);
            this.textBoxIP.TabIndex = 11;
            this.textBoxIP.Text = "127.0.0.1";
            // 
            // radioButton1
            // 
            this.radioButton1.AutoSize = true;
            this.radioButton1.Location = new System.Drawing.Point(6, 15);
            this.radioButton1.Name = "radioButton1";
            this.radioButton1.Size = new System.Drawing.Size(31, 17);
            this.radioButton1.TabIndex = 12;
            this.radioButton1.TabStop = true;
            this.radioButton1.Text = "1";
            this.radioButton1.UseVisualStyleBackColor = true;
            // 
            // groupBoxLevel
            // 
            this.groupBoxLevel.Controls.Add(this.radioButton4);
            this.groupBoxLevel.Controls.Add(this.radioButton3);
            this.groupBoxLevel.Controls.Add(this.radioButton2);
            this.groupBoxLevel.Controls.Add(this.radioButton1);
            this.groupBoxLevel.Location = new System.Drawing.Point(4, 65);
            this.groupBoxLevel.Name = "groupBoxLevel";
            this.groupBoxLevel.Size = new System.Drawing.Size(133, 42);
            this.groupBoxLevel.TabIndex = 13;
            this.groupBoxLevel.TabStop = false;
            this.groupBoxLevel.Text = "level";
            // 
            // radioButton4
            // 
            this.radioButton4.AutoSize = true;
            this.radioButton4.Location = new System.Drawing.Point(106, 15);
            this.radioButton4.Name = "radioButton4";
            this.radioButton4.Size = new System.Drawing.Size(31, 17);
            this.radioButton4.TabIndex = 15;
            this.radioButton4.TabStop = true;
            this.radioButton4.Text = "4";
            this.radioButton4.UseVisualStyleBackColor = true;
            // 
            // radioButton3
            // 
            this.radioButton3.AutoSize = true;
            this.radioButton3.Location = new System.Drawing.Point(74, 15);
            this.radioButton3.Name = "radioButton3";
            this.radioButton3.Size = new System.Drawing.Size(31, 17);
            this.radioButton3.TabIndex = 14;
            this.radioButton3.TabStop = true;
            this.radioButton3.Text = "3";
            this.radioButton3.UseVisualStyleBackColor = true;
            // 
            // radioButton2
            // 
            this.radioButton2.AutoSize = true;
            this.radioButton2.Location = new System.Drawing.Point(41, 15);
            this.radioButton2.Name = "radioButton2";
            this.radioButton2.Size = new System.Drawing.Size(31, 17);
            this.radioButton2.TabIndex = 13;
            this.radioButton2.TabStop = true;
            this.radioButton2.Text = "2";
            this.radioButton2.UseVisualStyleBackColor = true;
            // 
            // button_copyP
            // 
            this.button_copyP.Location = new System.Drawing.Point(99, 166);
            this.button_copyP.Name = "button_copyP";
            this.button_copyP.Size = new System.Drawing.Size(38, 49);
            this.button_copyP.TabIndex = 14;
            this.button_copyP.Text = "C";
            this.button_copyP.UseVisualStyleBackColor = true;
            this.button_copyP.Click += new System.EventHandler(this.button_copyP_Click);
            // 
            // button_problemb
            // 
            this.button_problemb.Location = new System.Drawing.Point(4, 278);
            this.button_problemb.Name = "button_problemb";
            this.button_problemb.Size = new System.Drawing.Size(39, 50);
            this.button_problemb.TabIndex = 16;
            this.button_problemb.Text = "P\'-3";
            this.button_problemb.UseVisualStyleBackColor = true;
            this.button_problemb.Click += new System.EventHandler(this.button_problemb_Click);
            // 
            // button_problemc
            // 
            this.button_problemc.Location = new System.Drawing.Point(4, 334);
            this.button_problemc.Name = "button_problemc";
            this.button_problemc.Size = new System.Drawing.Size(39, 50);
            this.button_problemc.TabIndex = 17;
            this.button_problemc.Text = "P\'\'-5";
            this.button_problemc.UseVisualStyleBackColor = true;
            this.button_problemc.Click += new System.EventHandler(this.button_problemc_Click);
            // 
            // button_problemb_plus
            // 
            this.button_problemb_plus.Location = new System.Drawing.Point(49, 278);
            this.button_problemb_plus.Name = "button_problemb_plus";
            this.button_problemb_plus.Size = new System.Drawing.Size(44, 50);
            this.button_problemb_plus.TabIndex = 18;
            this.button_problemb_plus.Text = "+ 4";
            this.button_problemb_plus.UseVisualStyleBackColor = true;
            this.button_problemb_plus.Click += new System.EventHandler(this.button_problemb_plus_Click);
            // 
            // button_problemc_plus
            // 
            this.button_problemc_plus.Location = new System.Drawing.Point(49, 334);
            this.button_problemc_plus.Name = "button_problemc_plus";
            this.button_problemc_plus.Size = new System.Drawing.Size(44, 50);
            this.button_problemc_plus.TabIndex = 19;
            this.button_problemc_plus.Text = "+ 6";
            this.button_problemc_plus.UseVisualStyleBackColor = true;
            this.button_problemc_plus.Click += new System.EventHandler(this.button_problemc_plus_Click);
            // 
            // button_chapterid_add
            // 
            this.button_chapterid_add.Location = new System.Drawing.Point(4, 39);
            this.button_chapterid_add.Name = "button_chapterid_add";
            this.button_chapterid_add.Size = new System.Drawing.Size(17, 21);
            this.button_chapterid_add.TabIndex = 20;
            this.button_chapterid_add.Text = "+";
            this.button_chapterid_add.UseVisualStyleBackColor = true;
            this.button_chapterid_add.Click += new System.EventHandler(this.button_chapterid_add_Click);
            // 
            // button_chapterid_sub
            // 
            this.button_chapterid_sub.Location = new System.Drawing.Point(67, 39);
            this.button_chapterid_sub.Name = "button_chapterid_sub";
            this.button_chapterid_sub.Size = new System.Drawing.Size(17, 21);
            this.button_chapterid_sub.TabIndex = 21;
            this.button_chapterid_sub.Text = "-";
            this.button_chapterid_sub.UseVisualStyleBackColor = true;
            this.button_chapterid_sub.Click += new System.EventHandler(this.button_chapterid_sub_Click);
            // 
            // button_index_sub
            // 
            this.button_index_sub.Location = new System.Drawing.Point(124, 12);
            this.button_index_sub.Name = "button_index_sub";
            this.button_index_sub.Size = new System.Drawing.Size(17, 21);
            this.button_index_sub.TabIndex = 22;
            this.button_index_sub.Text = "-";
            this.button_index_sub.UseVisualStyleBackColor = true;
            this.button_index_sub.Click += new System.EventHandler(this.button_index_sub_Click);
            // 
            // button_index_add
            // 
            this.button_index_add.Location = new System.Drawing.Point(62, 12);
            this.button_index_add.Name = "button_index_add";
            this.button_index_add.Size = new System.Drawing.Size(17, 21);
            this.button_index_add.TabIndex = 23;
            this.button_index_add.Text = "+";
            this.button_index_add.UseVisualStyleBackColor = true;
            this.button_index_add.Click += new System.EventHandler(this.button_index_add_Click);
            // 
            // button_reset
            // 
            this.button_reset.Location = new System.Drawing.Point(99, 334);
            this.button_reset.Name = "button_reset";
            this.button_reset.Size = new System.Drawing.Size(38, 50);
            this.button_reset.TabIndex = 24;
            this.button_reset.Text = "R";
            this.button_reset.UseVisualStyleBackColor = true;
            this.button_reset.Click += new System.EventHandler(this.button_reset_Click);
            // 
            // button_update
            // 
            this.button_update.Location = new System.Drawing.Point(99, 113);
            this.button_update.Name = "button_update";
            this.button_update.Size = new System.Drawing.Size(42, 47);
            this.button_update.TabIndex = 25;
            this.button_update.Text = "Upd (R)";
            this.button_update.UseVisualStyleBackColor = true;
            this.button_update.Click += new System.EventHandler(this.button_update_Click);
            // 
            // textBox_idproblem
            // 
            this.textBox_idproblem.Location = new System.Drawing.Point(99, 301);
            this.textBox_idproblem.Name = "textBox_idproblem";
            this.textBox_idproblem.Size = new System.Drawing.Size(37, 20);
            this.textBox_idproblem.TabIndex = 26;
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(142, 392);
            this.Controls.Add(this.textBox_idproblem);
            this.Controls.Add(this.button_update);
            this.Controls.Add(this.button_reset);
            this.Controls.Add(this.button_index_add);
            this.Controls.Add(this.button_index_sub);
            this.Controls.Add(this.button_chapterid_sub);
            this.Controls.Add(this.button_chapterid_add);
            this.Controls.Add(this.button_problemc_plus);
            this.Controls.Add(this.button_problemb_plus);
            this.Controls.Add(this.button_problemc);
            this.Controls.Add(this.button_problemb);
            this.Controls.Add(this.button_copyP);
            this.Controls.Add(this.groupBoxLevel);
            this.Controls.Add(this.textBoxIP);
            this.Controls.Add(this.textBoxChapterID);
            this.Controls.Add(this.buttonReview);
            this.Controls.Add(this.comboBox_index);
            this.Controls.Add(this.button_submit);
            this.Controls.Add(this.button_answer_plus);
            this.Controls.Add(this.button_answer);
            this.Controls.Add(this.button_problem_plus);
            this.Controls.Add(this.button_problem);
            this.Controls.Add(this.comboBox_module);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "MainForm";
            this.Text = "Capture";
            this.groupBoxLevel.ResumeLayout(false);
            this.groupBoxLevel.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ComboBox comboBox_module;
        private System.Windows.Forms.Button button_problem;
        private System.Windows.Forms.Button button_problem_plus;
        private System.Windows.Forms.Button button_answer_plus;
        private System.Windows.Forms.Button button_answer;
        private System.Windows.Forms.Button button_submit;
        private System.Windows.Forms.ComboBox comboBox_index;
        private System.Windows.Forms.Button buttonReview;
        private System.Windows.Forms.TextBox textBoxChapterID;
        private System.Windows.Forms.TextBox textBoxIP;
        private System.Windows.Forms.RadioButton radioButton1;
        private System.Windows.Forms.GroupBox groupBoxLevel;
        private System.Windows.Forms.RadioButton radioButton4;
        private System.Windows.Forms.RadioButton radioButton3;
        private System.Windows.Forms.RadioButton radioButton2;
        private System.Windows.Forms.Button button_copyP;
        private System.Windows.Forms.Button button_problemb;
        private System.Windows.Forms.Button button_problemc;
        private System.Windows.Forms.Button button_problemb_plus;
        private System.Windows.Forms.Button button_problemc_plus;
        private System.Windows.Forms.Button button_chapterid_add;
        private System.Windows.Forms.Button button_chapterid_sub;
        private System.Windows.Forms.Button button_index_sub;
        private System.Windows.Forms.Button button_index_add;
        private System.Windows.Forms.Button button_reset;
        private System.Windows.Forms.Button button_update;
        private System.Windows.Forms.TextBox textBox_idproblem;
    }
}


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
            this.radioButton2 = new System.Windows.Forms.RadioButton();
            this.radioButton3 = new System.Windows.Forms.RadioButton();
            this.radioButton4 = new System.Windows.Forms.RadioButton();
            this.groupBoxLevel.SuspendLayout();
            this.SuspendLayout();
            // 
            // comboBox_module
            // 
            this.comboBox_module.FormattingEnabled = true;
            this.comboBox_module.Location = new System.Drawing.Point(12, 12);
            this.comboBox_module.Name = "comboBox_module";
            this.comboBox_module.Size = new System.Drawing.Size(92, 21);
            this.comboBox_module.TabIndex = 0;
            // 
            // button_problem
            // 
            this.button_problem.Location = new System.Drawing.Point(12, 309);
            this.button_problem.Name = "button_problem";
            this.button_problem.Size = new System.Drawing.Size(50, 50);
            this.button_problem.TabIndex = 1;
            this.button_problem.Text = "P";
            this.button_problem.UseVisualStyleBackColor = true;
            this.button_problem.Click += new System.EventHandler(this.button_problem_Click);
            // 
            // button_problem_plus
            // 
            this.button_problem_plus.Location = new System.Drawing.Point(68, 309);
            this.button_problem_plus.Name = "button_problem_plus";
            this.button_problem_plus.Size = new System.Drawing.Size(36, 50);
            this.button_problem_plus.TabIndex = 2;
            this.button_problem_plus.Text = "+";
            this.button_problem_plus.UseVisualStyleBackColor = true;
            this.button_problem_plus.Click += new System.EventHandler(this.button_problem_plus_Click);
            // 
            // button_answer_plus
            // 
            this.button_answer_plus.Location = new System.Drawing.Point(68, 365);
            this.button_answer_plus.Name = "button_answer_plus";
            this.button_answer_plus.Size = new System.Drawing.Size(36, 50);
            this.button_answer_plus.TabIndex = 4;
            this.button_answer_plus.Text = "+";
            this.button_answer_plus.UseVisualStyleBackColor = true;
            this.button_answer_plus.Click += new System.EventHandler(this.button_answer_plus_Click);
            // 
            // button_answer
            // 
            this.button_answer.Location = new System.Drawing.Point(12, 365);
            this.button_answer.Name = "button_answer";
            this.button_answer.Size = new System.Drawing.Size(50, 50);
            this.button_answer.TabIndex = 3;
            this.button_answer.Text = "A";
            this.button_answer.UseVisualStyleBackColor = true;
            this.button_answer.Click += new System.EventHandler(this.button_answer_Click);
            // 
            // button_submit
            // 
            this.button_submit.Location = new System.Drawing.Point(12, 421);
            this.button_submit.Name = "button_submit";
            this.button_submit.Size = new System.Drawing.Size(91, 49);
            this.button_submit.TabIndex = 5;
            this.button_submit.Text = "Submit";
            this.button_submit.UseVisualStyleBackColor = true;
            this.button_submit.Click += new System.EventHandler(this.button_submit_Click);
            // 
            // comboBox_index
            // 
            this.comboBox_index.FormattingEnabled = true;
            this.comboBox_index.Location = new System.Drawing.Point(11, 39);
            this.comboBox_index.Name = "comboBox_index";
            this.comboBox_index.Size = new System.Drawing.Size(92, 21);
            this.comboBox_index.TabIndex = 7;
            // 
            // buttonReview
            // 
            this.buttonReview.Location = new System.Drawing.Point(12, 180);
            this.buttonReview.Name = "buttonReview";
            this.buttonReview.Size = new System.Drawing.Size(92, 63);
            this.buttonReview.TabIndex = 9;
            this.buttonReview.Text = "Review";
            this.buttonReview.UseVisualStyleBackColor = true;
            // 
            // textBoxChapterID
            // 
            this.textBoxChapterID.Location = new System.Drawing.Point(12, 66);
            this.textBoxChapterID.Name = "textBoxChapterID";
            this.textBoxChapterID.Size = new System.Drawing.Size(92, 20);
            this.textBoxChapterID.TabIndex = 10;
            // 
            // textBoxIP
            // 
            this.textBoxIP.Location = new System.Drawing.Point(12, 249);
            this.textBoxIP.Name = "textBoxIP";
            this.textBoxIP.Size = new System.Drawing.Size(92, 20);
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
            this.groupBoxLevel.Location = new System.Drawing.Point(12, 92);
            this.groupBoxLevel.Name = "groupBoxLevel";
            this.groupBoxLevel.Size = new System.Drawing.Size(92, 56);
            this.groupBoxLevel.TabIndex = 13;
            this.groupBoxLevel.TabStop = false;
            this.groupBoxLevel.Text = "level";
            // 
            // radioButton2
            // 
            this.radioButton2.AutoSize = true;
            this.radioButton2.Location = new System.Drawing.Point(44, 15);
            this.radioButton2.Name = "radioButton2";
            this.radioButton2.Size = new System.Drawing.Size(31, 17);
            this.radioButton2.TabIndex = 13;
            this.radioButton2.TabStop = true;
            this.radioButton2.Text = "2";
            this.radioButton2.UseVisualStyleBackColor = true;
            // 
            // radioButton3
            // 
            this.radioButton3.AutoSize = true;
            this.radioButton3.Location = new System.Drawing.Point(6, 39);
            this.radioButton3.Name = "radioButton3";
            this.radioButton3.Size = new System.Drawing.Size(31, 17);
            this.radioButton3.TabIndex = 14;
            this.radioButton3.TabStop = true;
            this.radioButton3.Text = "3";
            this.radioButton3.UseVisualStyleBackColor = true;
            // 
            // radioButton4
            // 
            this.radioButton4.AutoSize = true;
            this.radioButton4.Location = new System.Drawing.Point(44, 39);
            this.radioButton4.Name = "radioButton4";
            this.radioButton4.Size = new System.Drawing.Size(31, 17);
            this.radioButton4.TabIndex = 15;
            this.radioButton4.TabStop = true;
            this.radioButton4.Text = "4";
            this.radioButton4.UseVisualStyleBackColor = true;
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(116, 482);
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
    }
}


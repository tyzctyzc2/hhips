using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using log4net;

namespace CaptureAir
{
    class ProblemSubmitter
    {
        public string problemdetail;
        public string problemanswerdetail;

        public int problemlevel;
        public string problemchapterid;
        public string problemindex;
        public string problemmodule;

        ILog log = LogManager.GetLogger(typeof(ProblemSubmitter));

        public bool Submit(string ip)
        {
            string targetUrl = "http://" + ip + ":8080/hhipsair/Problem/new";
            string data = "{\"problemanswerdetail\":\"" + problemanswerdetail + "\"," +
                          "\"problemanswerstring\":\"" + "" + "\"," +
                          "\"problemchapterid\":" + problemchapterid + "," +
                          "\"problemdetail\":\"" + problemdetail + "\"," +
                          "\"problemindex\":\"" + problemindex + "\"," +
                          "\"problemlevel\":\"" + problemlevel + "\"," +
                          "\"problemmodule\":\"" + problemmodule + "\"}";


            log.Info("targetUrl = " + targetUrl);
            log.Debug("data = " + data);
            return DoPostOnURL(targetUrl, data);
        }

        bool DoPostOnURL(string targetURL, string data)
        {
            string DefaultUserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)";
            HttpWebRequest request = null;
            try
            {
                request = WebRequest.Create(targetURL) as HttpWebRequest;
            }
            catch
            {
                if (request == null)
                    return false;
            }
            byte[] postBytes = Encoding.UTF8.GetBytes(data);
            request.Method = "POST";
            request.UserAgent = DefaultUserAgent;
            request.ContentType = "application/json; charset=UTF-8";
            request.Accept = "application/json";
            request.ContentLength = postBytes.Length;
            HttpWebResponse response = null;

            Stream requestStream = request.GetRequestStream();

            // now send it
            requestStream.Write(postBytes, 0, postBytes.Length);
            requestStream.Close();

            try
            {
                response = (HttpWebResponse)request.GetResponse();
                log.Info("response = " + response);
            }
            catch(Exception e)
            {
                log.Error(e.ToString());
                log.Error(e.StackTrace);
            }
            if ((response != null) && (response.StatusCode == HttpStatusCode.OK))
            {
                Stream receiveStream = response.GetResponseStream();
                StreamReader readStream = null;
                if (response.CharacterSet == null)
                    readStream = new StreamReader(receiveStream);
                else
                    readStream = new StreamReader(receiveStream, Encoding.GetEncoding(response.CharacterSet));
                data = readStream.ReadToEnd();
                response.Close();
                readStream.Close();
            }
            return true;
        }
    }
}

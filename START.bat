# Sentinel Drone Fleet — Step-by-Step Setup Guide

This guide walks you through making Sentinel accessible online so external pilots can log in and admins can track live drone telemetry. Take your time with each step.

---

## Overview (What We're Building)

- **Your website (acss.co.za)** — Where pilots and admins open the app
- **Oracle server** — Runs the data and live telemetry in the background
- **Result** — Pilots log in from anywhere; admins see live drone positions on the map

---

# PART 1: Create Your Oracle Free Server

---

## Step 1.1 — Create an Oracle Cloud Account

1. Open your web browser.
2. Go to: **https://www.oracle.com/cloud/free/**
3. Click the **"Start for free"** button.
4. Fill in:
   - Email address
   - Country (South Africa)
   - First and last name
5. Click **Next**.
6. Enter a password and confirm it.
7. Choose your home region (e.g. **South Africa (Johannesburg)** if available, or closest).
8. Oracle will ask for a credit card. This is for verification only. The free VM does not charge you.
9. Complete the signup. Check your email and verify if asked.

**Stop here.** When your account is ready, come back and continue to Step 1.2.

---

## Step 1.2 — Log Into Oracle Cloud

1. Go to: **https://cloud.oracle.com**
2. Enter your email and password.
3. Click **Sign In**.
4. You should see the Oracle Cloud dashboard.

**Stop here.** When you see the dashboard, continue to Step 1.3.

---

## Step 1.3 — Create a Compute Instance (Your Server)

1. Click the **☰** (three horizontal lines) in the top-left corner.
2. Click **Compute**.
3. Click **Instances**.
4. Click the **Create Instance** button.
5. Fill in:
   - **Name:** `sentinel` (or any name you like)
   - **Placement:** leave default
   - **Image and shape:** Click **Edit**
     - Choose **Ubuntu 22.04**
     - Shape: **VM.Standard.E2.1.Micro** (this is the free one)
   - **Add SSH keys:** Choose **Generate a key pair for me**
     - Click **Save Private Key** — save the file somewhere safe (e.g. Desktop). You will need it later.
     - Click **Save Public Key** (optional backup)
6. Click **Create** at the bottom.
7. Wait 1–2 minutes until the instance status shows **Running** (green).

**Stop here.** Write down or copy your **Public IP address** (shown on the instance page). You will need it later.

---

## Step 1.4 — Open the Firewall (Allow Traffic)

1. On your instance page, look for **Primary VNIC** or **Subnet**.
2. Click the subnet link.
3. Click the **Security List** (or Default Security List).
4. Click **Add Ingress Rules** (or **Add Rule**).
5. Add these rules one by one:

   | Source CIDR | Destination Port | Description    |
   |-------------|------------------|----------------|
   | 0.0.0.0/0   | 22               | SSH            |
   | 0.0.0.0/0   | 80               | Web (HTTP)     |
   | 0.0.0.0/0   | 8080             | API            |
   | 0.0.0.0/0   | 8081             | WebSocket      |

6. Click **Add Ingress Rules** to save each one.

**Stop here.** When the rules are added, continue to Part 2.

---

# PART 2: Connect to Your Oracle Server

---

## Step 2.1 — Install PuTTY (Windows) or Use Terminal (Mac)

**On Windows:**
1. Download PuTTY: **https://www.putty.org/**
2. Install it.
3. Or use **Windows Terminal** / **PowerShell** if you prefer.

**On Mac:**
- Use the built-in **Terminal** app.

**Stop here.** When you have PuTTY or Terminal ready, continue to Step 2.2.

---

## Step 2.2 — Connect via SSH

**On Windows (PuTTY):**
1. Open PuTTY.
2. Host: `ubuntu@YOUR_PUBLIC_IP` (replace YOUR_PUBLIC_IP with the IP from Step 1.3).
3. Port: 22.
4. Connection type: SSH.
5. Click **Open**.
6. When asked about the key, click **Yes**.
7. It may ask for a passphrase — if you didn't set one, press Enter.

**On Windows (PowerShell):**
1. Open PowerShell.
2. Run: `ssh -i "C:\path\to\your\key.pem" ubuntu@YOUR_PUBLIC_IP`
   - Replace the path with where you saved the .pem file.
   - Replace YOUR_PUBLIC_IP with your server IP.

**On Mac:**
1. Open Terminal.
2. Run: `chmod 400 /path/to/your/key.pem`
3. Run: `ssh -i /path/to/your/key.pem ubuntu@YOUR_PUBLIC_IP`

When you see a prompt like `ubuntu@sentinel:~$`, you are connected.

**Stop here.** When you are connected, continue to Part 3.

---

# PART 3: Install Software on the Oracle Server

---

## Step 3.1 — Update the Server

In the SSH window, type each command and press Enter. Wait for each to finish before typing the next.

```
sudo apt update
```

```
sudo apt upgrade -y
```

This may take a few minutes.

---

## Step 3.2 — Install Python and Unzip

```
sudo apt install -y python3 python3-venv unzip nginx
```

Wait for it to finish.

---

## Step 3.3 — Create a Folder for Sentinel

```
mkdir -p ~/sentinel
cd ~/sentinel
```

**Stop here.** You now have a folder ready. Continue to Part 4 to upload your files.

---

# PART 4: Upload Sentinel Files to Oracle

---

## Step 4.1 — On Your PC: Zip the Project

1. Open **File Explorer** (Windows) or **Finder** (Mac).
2. Go to: `C:\Projects\Sentinel - Drone Fleet` (or wherever your project is).
3. Select these items:
   - `index.html`
   - `main.js`
   - `styles.css`
   - `config.js`
   - `api` (the whole folder)
4. Right-click → **Send to** → **Compressed (zipped) folder**.
5. Name it `sentinel.zip`.
6. Remember where you saved it (e.g. Desktop).

---

## Step 4.2 — Upload Using SCP (From Your PC)

**On Windows (PowerShell):**
1. Open PowerShell.
2. Go to the folder with sentinel.zip, e.g.:
   ```
   cd C:\Users\YourName\Desktop
   ```
3. Run (replace the path and IP):
   ```
   scp -i "C:\path\to\your\key.pem" sentinel.zip ubuntu@YOUR_PUBLIC_IP:~/sentinel/
   ```

**On Mac:**
```
scp -i /path/to/your/key.pem sentinel.zip ubuntu@YOUR_PUBLIC_IP:~/sentinel/
```

Wait until the upload finishes.

---

## Step 4.3 — On the Server: Unzip and Prepare

Back in your SSH window (connected to Oracle):

```
cd ~/sentinel
unzip sentinel.zip
ls
```

You should see `index.html`, `main.js`, `api`, etc.

**If files are inside a subfolder** (e.g. "Sentinel - Drone Fleet"):
```
mv "Sentinel - Drone Fleet"/* .
```

---

## Step 4.4 — Edit config.js for Your Server

We need to tell the app to use your Oracle server. On your **PC**, before uploading, or on the server:

1. Open `config.js` in a text editor.
2. Change the line to:
   ```
   window.SENTINEL_API_HOST = 'YOUR_PUBLIC_IP';
   ```
   Replace `YOUR_PUBLIC_IP` with your actual Oracle IP (e.g. `123.45.67.89`).
3. Save the file.

If you already uploaded, you can edit on the server:
```
nano ~/sentinel/config.js
```
Change the line, then press `Ctrl+O` to save, `Enter`, then `Ctrl+X` to exit.

**Stop here.** When config.js points to your Oracle IP, continue to Part 5.

---

# PART 5: Run the API on Oracle

---

## Step 5.1 — Start the API Server (Test Run)

In your SSH window:

```
cd ~/sentinel
python3 api/server.py
```

You should see messages like:
- `[HTTP] API server on http://0.0.0.0:8080/api`
- `[WS] WebSocket ready on ws://0.0.0.0:8081`

**Leave this window open.** The server is now running.

---

## Step 5.2 — Test From Your Browser

1. On your PC, open a new browser tab.
2. Go to: `http://YOUR_PUBLIC_IP:8080/api`
3. You should see something like `{"ok":true}` or a JSON response.

If that works, your API is running correctly.

**Stop here.** When the test works, continue to Part 6. (You can press `Ctrl+C` in the SSH window to stop the server for now.)

---

# PART 6: Make the Server Run Automatically (Optional but Recommended)

---

## Step 6.1 — Create a Service File

In SSH:

```
sudo nano /etc/systemd/system/sentinel.service
```

Paste this (replace YOUR_USERNAME with your actual username, usually `ubuntu`):

```
[Unit]
Description=Sentinel Drone Fleet API
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/sentinel
ExecStart=/usr/bin/python3 /home/ubuntu/sentinel/api/server.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Press `Ctrl+O`, Enter, then `Ctrl+X`.

---

## Step 6.2 — Enable and Start the Service

```
sudo systemctl daemon-reload
sudo systemctl enable sentinel
sudo systemctl start sentinel
sudo systemctl status sentinel
```

You should see `active (running)` in green.

---

## Step 6.3 — Serve the UI with Nginx (Optional)

So you can open the app at `http://YOUR_IP/` instead of a long path:

```
sudo cp ~/sentinel/index.html /var/www/html/
sudo cp ~/sentinel/main.js /var/www/html/
sudo cp ~/sentinel/styles.css /var/www/html/
sudo cp ~/sentinel/config.js /var/www/html/
```

Then open: `http://YOUR_PUBLIC_IP/`

**Stop here.** Your Oracle server is now running Sentinel. Continue to Part 7 to connect Axess.

---

# PART 7: Connect Axess (acss.co.za) to Your Oracle Server

---

## Step 7.1 — Update config.js for Axess

The `config.js` you upload to **Axess** must point to your Oracle server.

1. On your PC, open `config.js`.
2. Set: `window.SENTINEL_API_HOST = 'YOUR_ORACLE_PUBLIC_IP';`
3. Save.

---

## Step 7.2 — Upload to Axess via FTP

1. Open FileZilla (or another FTP client).
2. Connect:
   - Host: `ftp.acss.co.za` or `156.155.252.86`
   - Username: `jehekqdz`
   - Password: (from your Axess panel)
   - Port: 21
3. On the right (remote), go to `public_html`.
4. Upload: `index.html`, `main.js`, `styles.css`, `config.js` (with Oracle IP set).

---

## Step 7.3 — Test

1. Open: **https://acss.co.za/**
2. You should see the Sentinel app.
3. Log in as admin (admin / admin123).
4. Check that drones, telemetry, etc. load.

---

# Summary

- **Oracle** = Runs the API and WebSocket (data + live telemetry).
- **Axess** = Hosts the UI at acss.co.za.
- **config.js** = Tells the UI to use your Oracle server.

If any step fails, note which step and what you see, and we can fix it.

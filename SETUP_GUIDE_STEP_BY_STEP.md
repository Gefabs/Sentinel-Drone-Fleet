# 🛸 SENTINEL - Comprehensive Drone Fleet Management System

A professional-grade web-based drone fleet management platform with real-time tracking, maintenance scheduling, document management, and analytics.

## Features

### 📡 Drone Management
- **Real-time tracking** with live position updates on interactive map
- **Drone inventory** with detailed specifications (model, serial number, battery status)
- **Status monitoring** (Active, Idle, Maintenance, Retired)
- **Maintenance status tracking** (Operational, Maintenance Due, Grounded)
- **Battery monitoring** with visual indicators
- **Flight hours logging** and tracking
- **Pilot assignment** with auto-management

### 👨‍✈️ Pilot Management
- **License tracking** with expiry alerts
- **Certification management** (DJI Certified, Industrial, etc.)
- **Flight hours record** and experience level
- **Contact information** and home base location
- **Status tracking** (Active, Inactive, On Leave, Retired)
- **Document attachment** support for licenses and certifications

### 🎯 Mission Planning & Scheduling
- **Mission scheduling** with date/time selection
- **Mission types** (Survey, Inspection, Mapping, Delivery, Monitoring, Training)
- **Drone and pilot assignment** with availability checking
- **Mission status tracking** (Pending, Approved, In Progress, Completed, Cancelled)
- **Location and notes** for mission context
- **Duration estimation** and logging

### 🔧 Maintenance Management
- **Preventive maintenance scheduling** with configurable intervals
- **Maintenance types** (Routine, Airframe, Battery, Firmware, Propellers, Sensors, Calibration, Inspection)
- **Cost estimation** and tracking
- **Technician assignment**
- **Status management** (Scheduled, In Progress, Completed, Due Soon, Overdue)
- **Task notes** and documentation

### 📄 Document Management
- **License and certification tracking** for pilots
- **Document upload** (PDF, Images)
- **Expiry date monitoring** with automatic alerts
- **Document preview** and attachment viewing
- **Status tracking** (Valid, Expiring Soon, Expired, Pending)

### 📊 Analytics & Reporting
- **Fleet statistics** (Total flight hours, missions count)
- **Operational efficiency** metrics
- **Active drone monitoring** (count and percentage)
- **Historical data** export and analysis
- **Performance trends** and insights

### ⚠️ Intelligent Alert System
- **Battery alerts** for low power conditions
- **License expiry** notifications
- **Document expiry** alerts
- **Maintenance due** warnings
- **Real-time monitoring** with automatic refresh
- **Critical vs Warning** severity levels

### 🗺️ Interactive Map Visualization
- **Leaflet-powered** mapping with OpenStreetMap
- **Real-time drone positions** with live updates
- **Status-based markers** (Active=Green, Idle=Blue, Maintenance=Red)
- **Drone information popups** with quick details
- **Flight track visualization** (optional)
- **Zoom and pan** controls

### 💾 Data Management
- **Local storage** with browser cache persistence
- **Export to JSON** for backup and sharing
- **Import from JSON** for data restoration
- **Automatic persistence** on all changes

## Installation & Usage

### Requirements
- Modern web browser (Chrome, Firefox, Safari, Edge)
- Leaflet.js (CDN included)
- Internet connection for map tiles

### Getting Started

1. **Open the application**
   ```bash
   # Simply open index.html in your browser
   ```

2. **Add Pilots**
   - Click on "Pilots" tab
   - Fill in pilot information (name, license, expiry date, etc.)
   - Click "Save Pilot"

3. **Add Drones**
   - Click on "Drones" tab
   - Enter drone details (name, model, serial number, etc.)
   - Assign a pilot
   - Click "Save Drone"

4. **Schedule Missions**
   - Click on "Missions" tab
   - Select drone and pilot
   - Set start/end times
   - Click "Schedule Mission"

5. **Track Maintenance**
   - Click on "Maintenance" tab
   - Assign to drone
   - Set maintenance type and due date
   - Click "Save Maintenance"

6. **Upload Documents**
   - Click on "Documents" tab
   - Assign to pilot
   - Upload document file (PDF or image)
   - Set expiry date
   - Click "Save Document"

## User Interface

### Header Bar
- **Search** function for quick filtering across all categories
- **Export** button to download fleet data as JSON
- **Import** button to restore data from JSON file
- **Subscription status** indicator
- **Storage status** indicator

### Tab Navigation
- **Drones** - Manage your drone fleet
- **Pilots** - Manage pilot information
- **Missions** - Plan and track flights
- **Maintenance** - Schedule maintenance tasks
- **Documents** - Manage licenses and certifications
- **Analytics** - View fleet statistics
- **Alerts** - Monitor critical events

### Interactive Map
- Shows real-time drone positions
- Color-coded by status
- Click markers for drone information
- Right-click for context menu (future)

## Data Structure

### Drone Object
```javascript
{
  id: "unique-id",
  name: "Eagle-1",
  model: "DJI Mavic 3",
  status: "active", // active, idle, maintenance, retired
  battery: 92,
  pilotId: "pilot-id",
  serialNumber: "1AJKD-M3-2024-001",
  maintenanceStatus: "operational",
  flightHours: 180,
  maxFlightTime: 46
}
```

### Pilot Object
```javascript
{
  id: "unique-id",
  name: "Ava Maseko",
  license: "RPL-1023",
  licenseExpiry: "2025-12-31",
  contact: "+27 82 000 0001",
  homeBase: "Cape Town",
  flightHours: 450,
  status: "active", // active, inactive, on-leave, retired
  certifications: ["DJI Certified", "Industrial"]
}
```

### Mission Object
```javascript
{
  id: "unique-id",
  title: "Agricultural Survey",
  droneId: "drone-id",
  pilotId: "pilot-id",
  startTime: "2025-12-01T10:00:00",
  endTime: "2025-12-01T11:00:00",
  type: "survey", // survey, inspection, mapping, delivery, monitoring, training
  status: "pending", // pending, approved, in-progress, completed, cancelled
  duration: 60,
  location: "Northern Fields",
  notes: "Map boundaries for irrigation"
}
```

## Keyboard Shortcuts

- `Ctrl+S` - Save current form (when applicable)
- `Ctrl+F` - Focus search bar
- `Esc` - Clear search

## Browser Support

- ✅ Chrome/Chromium 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+

## Performance Tips

1. **Use search** to quickly find specific items
2. **Regular exports** for backup safety
3. **Clear old data** to improve performance
4. **Update browser** to latest version

## Troubleshooting

### Data not saving?
- Check browser local storage is enabled
- Try clearing cache and reloading
- Check browser console for errors

### Map not showing?
- Verify internet connection (for map tiles)
- Check Leaflet library loaded correctly
- Try refreshing the page

### Export/Import not working?
- Check file format is valid JSON
- Ensure file size is reasonable
- Try a smaller data set first

## Future Enhancements

- 🔒 User authentication and multi-team support
- 🌐 Cloud synchronization
- 📱 Mobile app (React Native)
- 🔔 Push notifications
- 🎥 Live video streaming integration
- 📈 Advanced analytics with charts
- 🤖 AI-powered maintenance prediction
- 🛰️ Real drone hardware integration
- 🌍 Geofencing and restricted zones
- 📊 Custom reporting engine

## License

This is a demonstration/prototype system. Use freely for personal and educational purposes.

## Support

For issues or feature requests, please document:
- Browser and version
- Steps to reproduce
- Expected vs actual behavior
- Screenshot/console errors

---

**Sentinel Fleet Management System** - Professional drone operations made simple.

# Payment Feature Setup Instructions

## Required: Add Privacy Descriptions in Xcode

Since we're using Contacts for payment recipient selection, you need to add privacy descriptions to your Xcode project.

### Steps:

1. **Open ClawTips.xcodeproj in Xcode**

2. **Select the ClawTips target** (in the left sidebar)

3. **Go to the "Info" tab**

4. **Add Custom iOS Target Properties:**

   Click the **"+"** button and add:

   **Key:** `Privacy - Contacts Usage Description` (or `NSContactsUsageDescription`)  
   **Value:** `Claw Tips needs access to your contacts to select people to send payments to when splitting bills.`

5. **Build and run!**

## How It Works

- When user taps "Send via Apple Cash" button
- App shows contact picker to select payment recipients  
- Opens Messages app with pre-filled amount and message
- User can send payment via Apple Cash through iMessage

## Testing

1. **Build the app** in simulator or device
2. **Calculate a bill** and split it
3. **Tap "Send via Apple Cash"** button
4. **Grant Contacts permission** when prompted (first time only)
5. **Select a contact**
6. **Messages app opens** with pre-filled payment amount
7. Send the message!

## Requirements

- iOS 16.0+
- Messages app available
- Apple Cash set up (for sender and recipient)
- Contacts access permission

## Troubleshooting

**Button is disabled:**
- Check if Messages app is available on device
- Simulators may not fully support Messages features

**Contact picker doesn't show:**
- Make sure privacy description is added
- Grant Contacts permission when prompted

**Messages doesn't open:**
- Check if MFMessageComposeViewController.canSendText() returns true
- Real device testing recommended for full functionality

---

**Note:** This feature works best on physical devices. iOS Simulator may have limitations with Messages integration.

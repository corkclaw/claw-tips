# TestFlight Deployment Guide

## Prerequisites

### 1. Apple Developer Account ($99/year)
- **Status:** ⏳ Needs enrollment
- **Sign up:** https://developer.apple.com/programs/enroll/
- **Approval time:** 24-48 hours
- **Required for:** TestFlight, App Store, code signing

### 2. Xcode Configuration
- ✅ Xcode 26.2 installed
- ✅ Project created
- ✅ App builds successfully

### 3. App Requirements
- ✅ App icon (1024x1024) - Done
- ✅ Bundle identifier: `com.clawsuite.ClawTips`
- ⏳ Privacy descriptions in Xcode (NSContactsUsageDescription)
- ⏳ Version and build number set

---

## Step-by-Step TestFlight Deployment

### Step 1: Enroll in Apple Developer Program

**If not already enrolled:**

1. Go to: https://developer.apple.com/programs/enroll/
2. Sign in with your Apple ID (corkonian@gmail.com)
3. Choose entity type:
   - **Individual** (easiest) - $99/year
   - **Organization** (requires D-U-N-S number)
4. Complete payment ($99 USD)
5. Wait 24-48 hours for approval
6. Check email for confirmation

**Once approved:**
- Access to App Store Connect
- Can create App IDs
- Can generate certificates & provisioning profiles
- TestFlight access enabled

---

### Step 2: Create App ID in Apple Developer Portal

1. Go to: https://developer.apple.com/account/
2. Navigate to **Certificates, Identifiers & Profiles**
3. Select **Identifiers** → Click **+**
4. Choose **App IDs** → Continue
5. Configure:
   - **Description:** Claw Tips
   - **Bundle ID:** `com.clawsuite.ClawTips` (Explicit)
   - **Capabilities:** (select if needed)
     - None required for MVP
6. Click **Continue** → **Register**

---

### Step 3: Create App in App Store Connect

1. Go to: https://appstoreconnect.apple.com/
2. Click **My Apps** → **+** → **New App**
3. Fill in details:
   - **Platform:** iOS
   - **Name:** Claw Tips
   - **Primary Language:** English (U.S.)
   - **Bundle ID:** `com.clawsuite.ClawTips`
   - **SKU:** `claw-tips-001` (unique identifier)
   - **User Access:** Full Access
4. Click **Create**

---

### Step 4: Configure App Information

In App Store Connect, fill in required fields:

**App Information:**
- **Category:** Finance or Utilities
- **Subcategory:** (optional)
- **Content Rights:** (who owns the content)

**Pricing and Availability:**
- **Price:** Free
- **Availability:** All countries (or select specific)

**App Privacy:**
- Will prompt during submission
- Declare: Contacts (for payment recipient selection)
- Purpose: "Selecting payment recipients"

**Version Information (1.0):**
- **Screenshots:** (can upload later for TestFlight)
- **Description:** "A simple, elegant tipping calculator for iOS. Calculate tips, split bills, and send payments via Apple Cash, Venmo, or Zelle."
- **Keywords:** tip calculator, bill splitter, payments, venmo, zelle
- **Support URL:** (your website or GitHub repo)
- **Marketing URL:** (optional)

---

### Step 5: Configure Xcode for Distribution

**A. Set Team & Signing**

1. Open `ClawTips.xcodeproj` in Xcode
2. Select **ClawTips target** (left sidebar)
3. Go to **Signing & Capabilities** tab
4. **Automatically manage signing:** ✅ Checked
5. **Team:** Select your Apple Developer team
6. Xcode will automatically:
   - Create certificates
   - Create provisioning profiles
   - Configure bundle identifier

**B. Add Privacy Descriptions**

In **ClawTips target → Info tab**, add:

| Key | Value |
|-----|-------|
| `NSContactsUsageDescription` | "Claw Tips needs access to your contacts to select people to send payments to when splitting bills." |

**C. Set Version & Build Number**

In **ClawTips target → General tab:**
- **Version:** 1.0
- **Build:** 1

---

### Step 6: Archive the App

1. In Xcode, select **Any iOS Device (arm64)** (not simulator)
2. Menu: **Product → Archive**
3. Wait for archive to complete (~2-5 minutes)
4. Xcode Organizer opens automatically

---

### Step 7: Upload to App Store Connect

In **Xcode Organizer:**

1. Select your archive
2. Click **Distribute App**
3. Choose **App Store Connect**
4. Click **Upload**
5. Distribution options:
   - **Include bitcode:** Yes (if available)
   - **Upload symbols:** Yes
   - **Manage version and build number:** (Xcode default)
6. Review and click **Upload**
7. Wait for upload (~5-15 minutes depending on connection)

---

### Step 8: Submit for TestFlight Review

Back in **App Store Connect:**

1. Go to **My Apps → Claw Tips**
2. Select **TestFlight** tab
3. Under **iOS**, you'll see your uploaded build
4. Fill in **Export Compliance** info:
   - Does your app use encryption? **No** (or Yes if applicable)
   - If No: Select "None of the above"
5. Add **Test Information:**
   - **Beta App Description:** Brief description for testers
   - **Feedback Email:** corkonian@gmail.com
   - **What to Test:** "Focus on tip calculation accuracy, bill splitting, and payment button functionality."
6. Click **Submit for Review**
7. Wait 12-48 hours for Apple review

---

### Step 9: Add Beta Testers

**Internal Testing (up to 100 testers):**
1. In App Store Connect → TestFlight
2. Click **Internal Testing**
3. Create group: "Internal Testers"
4. Add testers by email
5. They receive TestFlight invite immediately

**External Testing (up to 10,000 testers):**
1. Create external test group
2. Add testers by email or public link
3. Requires TestFlight app review first
4. Testers receive invite after approval

---

### Step 10: Testers Install via TestFlight

**For testers:**

1. Install **TestFlight** app from App Store
2. Check email for invite
3. Tap **View in TestFlight**
4. Tap **Install**
5. App appears on home screen
6. Can send feedback via TestFlight app

---

## Fastlane Automation (Optional but Recommended)

Once manual process works, automate with Fastlane:

```ruby
# Fastfile
lane :beta do
  increment_build_number
  build_app(scheme: "ClawTips")
  upload_to_testflight(
    skip_waiting_for_build_processing: true,
    changelog: "Bug fixes and improvements"
  )
end
```

Run: `fastlane beta`

---

## Troubleshooting

**"No signing certificate found"**
- Enable **Automatically manage signing** in Xcode
- Or manually create certificates in Developer Portal

**"Missing compliance"**
- Answer export compliance questions in App Store Connect
- Most apps: "No encryption" (unless using HTTPS for sensitive data)

**Build not appearing in TestFlight**
- Wait 10-15 minutes for processing
- Check email for errors from App Store Connect
- Review build status in Activity tab

**TestFlight review rejected**
- Common issues: Missing app description, unclear purpose
- Fix and resubmit

---

## Checklist Before Upload

- [ ] Apple Developer account enrolled and approved
- [ ] App ID created in Developer Portal
- [ ] App created in App Store Connect
- [ ] Xcode signing configured with team
- [ ] Privacy descriptions added (NSContactsUsageDescription)
- [ ] Version and build number set
- [ ] App icon added (1024x1024)
- [ ] App builds successfully
- [ ] Archive created
- [ ] Uploaded to App Store Connect
- [ ] Export compliance completed
- [ ] Submitted for TestFlight review
- [ ] Testers added

---

## Costs & Timeline

| Item | Cost | Timeline |
|------|------|----------|
| Apple Developer | $99/year | 24-48h approval |
| TestFlight review | Free | 12-48h review |
| Total to first tester | $99 | 2-4 days |

---

## Next Steps After TestFlight

1. **Gather feedback** from testers
2. **Iterate** on bugs and features
3. **Update builds** (increment build number each time)
4. **When ready:** Submit to App Store
   - Requires screenshots (6.7", 6.5", 5.5" displays)
   - App Store review (~24-48 hours)
   - Once approved: Live on App Store!

---

**Last Updated:** 2026-02-19  
**App:** Claw Tips v1.0  
**Bundle ID:** com.clawsuite.ClawTips

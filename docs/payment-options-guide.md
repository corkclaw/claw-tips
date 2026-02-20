# Payment Options Guide

**Claw Tips** now supports 3 payment methods for splitting bills:

## 1. Apple Cash 🍎

**How it works:**
- Tap the Apple Cash button
- Select contacts from your address book
- Messages opens with pre-filled amount
- Send via Apple Cash through iMessage

**Requirements:**
- iOS Messages app
- Apple Cash set up
- Contacts permission
- Recipients must have Apple Cash

**Availability:** Always available on iOS devices with Messages

---

## 2. Venmo 💙

**How it works:**
- Tap the Venmo button
- App opens Venmo directly
- Amount and note pre-filled
- Complete payment in Venmo app

**Requirements:**
- Venmo app installed
- Venmo account set up
- Recipient's Venmo username

**Deep Link:** `venmo://paycharge?txn=pay&amount=X&note=...`

**Availability:** Detected automatically if Venmo app is installed

**Brand Colors:**
- Primary: #3D95CE (Venmo Blue)
- Button uses official Venmo blue

---

## 3. Zelle 💜

**How it works:**
- Tap the Zelle button
- Shows instructions with amount
- Open your banking app
- Send via Zelle manually

**Requirements:**
- Banking app with Zelle integration
- Recipient's email or phone number enrolled in Zelle

**Availability:** Always available (shows instructions)

**Brand Colors:**
- Primary: #6D1ED4 (Zelle Purple)
- Button uses official Zelle purple

---

## Button Layout

All three buttons share equal space in a horizontal layout:

```
┌─────────────┬─────────────┬─────────────┐
│ 🍎 Apple    │ 💙 Venmo    │ 💜 Zelle    │
│   Cash      │             │             │
└─────────────┴─────────────┴─────────────┘
```

**Design:**
- Equal width (1/3 each)
- Brand colors when enabled
- Gray when disabled/unavailable
- Icon + text label
- Tap to initiate payment

---

## Availability Detection

The app automatically detects which payment methods are available:

| Method | Detection Logic |
|--------|----------------|
| **Apple Cash** | `MFMessageComposeViewController.canSendText()` |
| **Venmo** | `canOpenURL("venmo://")` - checks if Venmo app installed |
| **Zelle** | Always available (manual instructions) |

Disabled buttons appear gray and cannot be tapped.

---

## User Flow

### For Apple Cash:
1. Tap button → Contact picker
2. Select recipient(s)
3. Messages opens with amount
4. Tap send

### For Venmo:
1. Tap button → Venmo app opens
2. Amount & note pre-filled
3. Select recipient in Venmo
4. Complete payment

### For Zelle:
1. Tap button → Instructions appear
2. Copy amount from alert
3. Open your banking app
4. Send via Zelle manually

---

## Error Handling

**Venmo not installed:**
- Error: "Venmo app not installed. Please install Venmo to send payments."
- Action: User can install Venmo from App Store

**Messages not available:**
- Apple Cash button disabled
- Gray appearance

**All methods unavailable:**
- Unlikely scenario
- At minimum, Zelle instructions always available

---

## Future Enhancements

Potential additions:
- Cash App integration
- PayPal.me links
- Request money (reverse flow)
- Payment history tracking
- Multiple recipient support for Venmo/Zelle
- Custom recipient input (phone/email)

---

## Developer Notes

### Adding New Payment Methods

To add a new payment method:

1. Add case to `PaymentMethod` enum
2. Define `brandColor` and `iconName`
3. Implement `deepLinkURL()` if applicable
4. Add availability check in `isAvailable`
5. Update `PaymentCoordinator.sendPayment()` with new case
6. Button automatically appears in UI

### Brand Guidelines

**Apple Cash:**
- Use Apple logo
- Black or system color
- Official Apple design guidelines

**Venmo:**
- Brand color: #3D95CE
- Use "V" icon or Venmo logo
- Follow Venmo brand guidelines
- Link: venmo://paycharge

**Zelle:**
- Brand color: #6D1ED4
- Use "Z" icon or Zelle logo  
- Follow Zelle brand guidelines
- Manual process (no deep link)

---

**Last Updated:** 2026-02-19  
**Version:** 1.1.0

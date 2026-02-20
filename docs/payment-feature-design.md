# Payment Feature - Technical Design

**Feature:** Send split bill amounts via Apple Cash

## Overview

Allow users to send their portion of the bill to others using Apple Pay/Apple Cash through iMessage integration.

## Implementation Approach

### Option Chosen: Apple Cash via Messages

**Why:**
- Native iOS integration
- No backend required
- Leverages existing Apple Cash setup
- Secure and trusted by users
- Free for personal transfers

**Frameworks Required:**
- `MessageUI` - For composing iMessage with payment
- `Contacts` / `ContactsUI` - For selecting recipients

## User Flow

1. User calculates bill and splits it
2. Taps "Send Payment" button
3. Selects contact(s) from Contact Picker
4. App opens Messages with:
   - Pre-filled amount (per-person share)
   - Message text: "Your share for dinner: $X.XX"
   - Apple Cash payment request/send option
5. User sends via iMessage
6. Recipient receives message with Apple Cash prompt

## Technical Components

### 1. Payment Coordinator
```swift
class PaymentCoordinator {
    func sendPayment(
        amount: Decimal,
        recipients: [Contact],
        message: String
    )
}
```

### 2. Contact Selection
- Use `CNContactPickerViewController`
- Filter contacts with phone numbers
- Support multiple recipient selection

### 3. Message Composition
- Use `MFMessageComposeViewController`
- Pre-fill amount and message
- Include Apple Cash payment link

## Privacy & Permissions

**Required:**
- Contacts access (for contact picker)
- Messages access (for sending)

**Privacy.plist entries:**
- `NSContactsUsageDescription`
- `NSMessagesUsageDescription`

## Limitations

1. **Requires Apple Cash**: User must have Apple Cash set up
2. **iOS Messages only**: Only works on iOS devices
3. **Manual send**: User must tap send in Messages app
4. **One-way**: Can send or request, but not automated deduction

## Alternative: Payment Links

For users without Apple Cash, also provide:
- Venmo link: `venmo://paycharge?txn=pay&amount=X&note=...`
- Zelle: Copy amount + instructions
- PayPal: `paypal.me` link
- Cash App: `cash.app/$username/amount`

## UI Components

### PaymentOptionsSheet
- Show Apple Cash (primary)
- Show alternatives (Venmo, Zelle, etc.)
- Copy amount option

### ContactSelectionView
- Search contacts
- Select multiple
- Display selected count

### PaymentConfirmationView
- Show amount per person
- List selected recipients
- Confirm and send button

## Testing Considerations

- Test with/without Apple Cash setup
- Test with/without Messages access
- Test contact selection with empty contacts
- Test multiple recipient sends
- Test amount formatting across currencies

## Future Enhancements (Phase 2+)

- Group payment tracking (who paid, who owes)
- Payment history
- Recurring split bills
- Integration with third-party APIs (Venmo, PayPal)
- Backend for payment coordination

---

**Status:** Ready for implementation
**Estimated Time:** 1 day

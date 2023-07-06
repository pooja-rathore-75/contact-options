# contact-options

### Challenge #2: Contact options

In this ruby challenge, please take care to provide clean & optimised code.

1. Refer to the below [Contact Options doc](https://www.notion.so/Contact-options-4b9dcd0b1af747aa8db5d77dd615bdc6?pvs=21). Pay close attention to the contacts given, how each contact ranking is calculated, and how to decide which option to show for each contact, e.g. Offer a `VIP` or `free` introduction. Hint: there can only be one contact who will be offered a `VIP` introduction.
    
    [Contact options](https://www.notion.so/Contact-options-4b9dcd0b1af747aa8db5d77dd615bdc6?pvs=21)
    
2. Create a `ContactOptions` class where it should:
    - Return all contacts, ordered alphabetically by their **last** name, and then by their **first** name
    - For each contact, also include their calculated ranking and contact option (`VIP` or `free`)
    
    <aside>
    ⚠️ Note that for this challenge, no database should be used for storing/fetching the `ContactOptions` data.
    
    </aside>
    
3. Create one or more unit tests that will test the above logic.


# Note:

To run the functioanlity:
 `ruby contact_options.rb`

To run the rspec:
   `rspec contact_options_spec.rb`

import { createClient } from "@supabase/supabase-js";

const supabase = createClient(process.env.API_URL!, process.env.ANON_KEY!);

export default supabase;
